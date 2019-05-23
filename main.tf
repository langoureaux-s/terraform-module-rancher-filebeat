terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "consul" {}
}

# Template provider
provider "template" {
  version = "~> 1.0"
}

# Get the project data
data "rancher_environment" "project" {
  name = "${var.project_name}"
}


locals {
  mem_limit               = "${var.container_memory != "" ? "mem_limit: ${var.container_memory}" : ""}"
  external_links          = "${length(var.external_links) > 0 ? "external_links: ${indent(6, "\n${join("\n", formatlist("- %s", var.external_links))}")}" : ""}"
  ports                   = "${length(var.ports) > 0 ? "ports: ${indent(6, "\n${join("\n", formatlist("- %s", var.ports))}")}" : ""}"
  scale                   = "${var.scale != "" ? "scale: ${var.scale}" : ""}"
  volumes                 = "${length(var.volumes) > 0 ? "volumes: ${indent(6, "\n${join("\n", formatlist("- %s", var.volumes))}")}" : ""}"
}


# Logstash without driver
data "template_file" "docker_compose_filebeat" {
  template = "${file("${path.module}/rancher/filebeat/docker-compose.yml")}"

  vars {
    filebeat_image            = "${var.image_name}"
    filebeat_version          = "${var.image_version}"
    mem_limit                 = "${local.mem_limit}"
    cpu_shares                = "${var.cpu_shares}"
    external_links            = "${local.external_links}"
    label_scheduling          = "${var.label_scheduling}"
    global_scheduling         = "${var.global_scheduling}"
    ports                     = "${local.ports}"
    commit_id                 = "${var.commit_id}"
    volumes                   = "${local.volumes}"
  }
}
data "template_file" "rancher_compose_filebeat" {
  template = "${file("${path.module}/rancher/filebeat/rancher-compose.yml")}"

  vars {
    scale                   = "${local.scale}"
  }
}
resource "rancher_stack" "this_filebeat" {
  
  name            = "${var.stack_name}"
  description     = "Filebeat - Ship logs events"
  environment_id  = "${data.rancher_environment.project.id}"
  scope           = "user"
  start_on_create = true
  finish_upgrade  = "${var.finish_upgrade}"
  docker_compose  = "${data.template_file.docker_compose_filebeat.rendered}"
  rancher_compose = "${data.template_file.rancher_compose_filebeat.rendered}"
}