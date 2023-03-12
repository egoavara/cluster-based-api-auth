variable "namespace" {
  type = object({
    base    = string
    daemon  = string
    ingress = string
    kiali   = string
  })
  default = {
    base    = "istio-system"
    daemon  = "istio-system"
    ingress = "istio-ingress"
    kiali   = "istio-kiali"
  }
}
