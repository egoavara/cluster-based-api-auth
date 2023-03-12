resource "helm_release" "kubernetes-dashboard" {

  name = "kubernetes-dashboard"

  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  namespace  = var.namespace

  create_namespace = true
  cleanup_on_fail  = true

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "protocolHttp"
    value = "true"
  }

  set {
    name  = "service.externalPort"
    value = 8001
  }

  set {
    name  = "replicaCount"
    value = 1
  }

  set {
    name  = "rbac.clusterReadOnlyRole"
    value = "true"
  }
}
