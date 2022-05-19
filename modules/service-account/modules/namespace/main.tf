resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.name
  }
}

variable "name" {
  type = string
}
