# terraform-invalid-submodule-repro

Run minikube with a minikube context in your `~/.kube/config`

## Reproduction

```sh
$ terraform version
Terraform v1.2.0
on darwin_amd64

$ terraform init
Initializing modules...
- service_account in modules/service-account
- service_account.namespace in modules/service-account/modules/namespace
There are some problems with the configuration, described below.

The Terraform configuration must be valid before initialization so that
Terraform can determine which modules and providers need to be installed.
╷
│ Error: Module is incompatible with count, for_each, and depends_on
│ 
│   on modules/service-account/main.tf line 42, in module "namespace":
│   42:   for_each = toset(["foo", "bar"])
│ 
│ The module at module.service_account is a legacy module which contains its own local provider configurations, and so calls to it may not use the count, for_each, or depends_on arguments.
│ 
│ If you also c
```
