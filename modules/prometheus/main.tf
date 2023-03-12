
resource "helm_release" "prometheus" {
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "prometheus"
  name             = "prometheus"
  namespace        = var.namespace
  version          = "19.7"
  create_namespace = true
  cleanup_on_fail  = true

  set {
    name  = "nodeExporter.hostRootfs"
    value = "false"
  }
}
