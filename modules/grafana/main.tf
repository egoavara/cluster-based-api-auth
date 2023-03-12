
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
    value = "answer-to-life-the-universe-and-everything"
  }
}
