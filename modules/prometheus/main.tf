resource "kubernetes_namespace" "namespace" {
  metadata {
    labels = {
      istio-injection = "enabled"
    }
    name = var.namespace
  }
}
resource "helm_release" "prometheus" {
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "prometheus"
  name             = "prometheus"
  namespace        = kubernetes_namespace.namespace.metadata[0].name
  version          = "19.7"
  create_namespace = false
  cleanup_on_fail  = true

  set {
    name  = "nodeExporter.hostRootfs"
    value = "false"
  }
}
