resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "kiali" {
  repository       = "https://kiali.org/helm-charts"
  chart            = "kiali-operator"
  name             = "kiali-operator"
  namespace        = kubernetes_namespace.namespace.metadata[0].name
  version          = "1.64"
  create_namespace = false
  cleanup_on_fail  = true

  set {
    name  = "cr.create"
    value = "true"
  }
  set {
    name  = "cr.namespace"
    value = var.istio-namespace
  }
  set {
    name  = "cr.spec.external_services.prometheus.url"
    value = var.prometheus-url
  }
  set {
    name  = "cr.spec.external_services.grafana.enable"
    value = true
  }
  set {
    name  = "cr.spec.external_services.grafana.in_cluster_url"
    value = var.grafana-url
  }
  set {
    name  = "cr.spec.external_services.grafana.url"
    value = var.grafana-url
  }


}
