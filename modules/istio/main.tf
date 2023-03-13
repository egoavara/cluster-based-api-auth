resource "kubernetes_namespace" "istio-system" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_namespace" "istio-ingress" {
  metadata {
    labels = {
      istio-injection = "enabled"
    }
    name = var.namespace-ingress
  }
}


resource "helm_release" "istio-base" {
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "base"
  name             = "istio-base"
  namespace        = kubernetes_namespace.istio-system.metadata[0].name
  version          = "1.17"
  create_namespace = false
  cleanup_on_fail  = true

}
resource "helm_release" "istiod" {
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "istiod"
  name             = "istiod"
  namespace        = kubernetes_namespace.istio-system.metadata[0].name
  version          = "1.17"
  create_namespace = false
  cleanup_on_fail  = true
  depends_on = [
    helm_release.istio-base
  ]
}

resource "helm_release" "istio-ingress" {
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "gateway"
  name             = "istio-ingress"
  namespace        = kubernetes_namespace.istio-ingress.metadata[0].name
  version          = "1.17"
  create_namespace = false
  cleanup_on_fail  = true
  depends_on = [
    helm_release.istiod
  ]
}
