# terraform-module-rancher-logstash

This module permit to deploy Logstash stack on Rancher.

```
terragrunt = {
  terraform {
    source = "git::https://github.com/langoureaux-s/terraform-module-rancher-cloud9.git"
  }
  
  project_name              = "test"
  stack_name                = "logstash"
  finish_upgrade            = "true"
  label_global_scheduling   = "processing=true"
  data_path                 = "/data/logstash"
  jvm_memory                = "2g"
  enable_monitoring         = "false"
  logstash_system_password  = "y1546n02h482I1u3"
  client_stack              = "elasticsearch/elasticsearch"
  number_workers            = "4"
  container_memory          = "4g"
  input_rules               = <<EOF
beats {
  port            => 5003
  ssl             => false
}
EOF
  output_rules              = <<EOF
elasticsearch {
  hosts       => [ "elasticsearch-client" ]
  index       => "logstash-logs"
  user        => "logstash"
  password    => "y1546n02h482I1u56"
}
EOF
}
```

> Don't forget to read the file `variables.tf` to get all informations about variables.