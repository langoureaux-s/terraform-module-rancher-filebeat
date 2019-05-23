variable "project_name" {
    description = "The project name (environment name)"
}
variable "stack_name" {
    description = "The name for the Elasticsearch stack"
}
variable "finish_upgrade" {
  description = "Automatically finish upgrade on Rancher when apply new plan"
}
variable "scale" {
  description = "Set the number of instance you should.Don't use it if you should global_scheduling as true"
  default = ""
}
variable "label_scheduling" {
  description = "The label to use when schedule this stack"
  default = ""
}
variable "global_scheduling" {
  description = "Set to true if you should to deploy on all node that match label_scheduling"
  default     = "true"
}
variable "commit_id" {
  description = "The commit id that build image. It's usefull to force pull new image when use always the same tag"
  default = ""
}


variable "image_version" {
  description = "The image version of Logstash to use"
  default = "6.5.4-1"
}
variable "image_name" {
  description = "The image name to use"
  default = "harbor.hm.dm.ad/logmanagement/filebeat"
}

variable "volumes" {
  description = "Volumes to mount on docker container"
  type = "list"
  default = []
}

variable "ports" {
  description = "Ports to expose on container"
  type = "list"
  default = []
}

variable "external_links" {
  description = "Links on container"
  type = "list"
  default = []
}
