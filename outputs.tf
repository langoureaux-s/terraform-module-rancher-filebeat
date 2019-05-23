locals {
  stack_id    = "${compact(concat(rancher_stack.this_filebeat.*.id, list("")))}"
  stack_name  = "${compact(concat(rancher_stack.this_filebeat.*.name, list("")))}"
}


output "stack_id" {
  value = "${join("", local.stack_id)}"
}

output "stack_name" {
  value = "${join("", local.stack_name)}/filebeat"
}