resource "random_password" "password" {
  length = 32
}

locals {
  password = {
    random   = random_password.password.result
    password = var.admin-password
  }[var.admin-auth]
}

resource "helm_release" "grafana" {
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  name             = "grafana"
  namespace        = var.namespace
  version          = "6.52"
  create_namespace = true
  cleanup_on_fail  = true

  set {
    name  = "adminPassword"
    value = local.password
  }
}
