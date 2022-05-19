resource "kubernetes_service_account" "terraform" {
  metadata {
    name = "terraform"
  }
}

data "kubernetes_secret" "terraform" {
  metadata {
    name      = kubernetes_service_account.terraform.default_secret_name
    namespace = kubernetes_service_account.terraform.metadata[0].namespace
  }
}

resource "kubernetes_cluster_role_binding" "terraform" {
  metadata {
    name = "terraform"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.terraform.metadata[0].name
    namespace = kubernetes_service_account.terraform.metadata[0].namespace
  }
}

provider "kubernetes" {
  alias = "terraform"
  
  config_path            = pathexpand("~/.kube/config")
  config_context_cluster = "minikube"
  token                  = data.kubernetes_secret.terraform.data["token"]
}


module "namespace" {
  source   = "./modules/namespace"
  for_each = toset(["foo", "bar"])

  name = each.value

  providers = {
    kubernetes = kubernetes.terraform
  }
}
