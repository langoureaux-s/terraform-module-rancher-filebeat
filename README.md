# terraform-module-rancher-filebeat

This module permit to deploy Filebeat stack on Rancher.


Sample:
```
module "filebeat" {
  source = "github.com/langoureaux-s/terraform-module-rancher-filebeat"
  
  project_name            = "test"
  stack_name              = "filebeat"
  label_scheduling        = "env=test,filebeat=true"
  finish_upgrade          = "true"
  container_memory        = "1g"
  volumes                 = ["/data/filebeat/ssl:/usr/share/filebeat/ssl", "/data/filebeat/conf:/conf", "/data/filebeat/data:/usr/share/filebeat/data", "/data/traces:/traces"]
}
```

> Don't forget to read the file `variables.tf` to get all informations about variables.