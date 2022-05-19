module "service_account" {
  source = "./modules/service-account"
}

provider "kubernetes" {
  config_context = "minikube"
  config_path    = pathexpand("~/.kube/config")
}
