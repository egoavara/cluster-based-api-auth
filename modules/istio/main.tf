
resource "helm_release" "istio-base" {
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "base"
  name             = "istio-base"
  namespace        = var.namespace.base
  version          = "1.17"
  create_namespace = true
  cleanup_on_fail  = true

}


resource "helm_release" "istiod" {
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "istiod"
  name             = "istiod"
  namespace        = var.namespace.daemon
  version          = "1.17"
  create_namespace = true
  cleanup_on_fail  = true
  depends_on = [
    helm_release.istio-base
  ]
}

resource "kubernetes_namespace" "istio-ingress" {
  metadata {
    labels = {
      istio-injection = "enabled"
    }

    name = var.namespace.ingress
  }
}

resource "helm_release" "istio-ingress" {
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"
  name       = "istio-ingress"
  namespace  = kubernetes_namespace.istio-ingress.metadata[0].name
  version    = "1.17"
  depends_on = [
    helm_release.istiod
  ]
}

resource "helm_release" "kiali" {
  repository       = "https://kiali.org/helm-charts"
  chart            = "kiali-operator"
  name             = "kiali-operator"
  namespace        = var.namespace.kiali
  version          = "1.64"
  create_namespace = true
  cleanup_on_fail  = true
  depends_on = [
    helm_release.istiod
  ]

  set {
    name  = "cr.create"
    value = "true"
  }
  set {
    name  = "cr.namespace"
    value = var.namespace.daemon
  }
  set {
    name  = "cr.spec.external_services.prometheus.url"
    value = "http://prometheus-server.prometheus/"
  }
}
