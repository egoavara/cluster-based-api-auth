variable "namespace" {
  type    = string
  default = "kiali"
}

variable "istio-namespace" {
  type    = string
  default = "istio-system"
}

variable "prometheus-url" {
  type    = string
  default = "http://prometheus-server.prometheus/"
}

variable "grafana-url" {
  type    = string
  default = "http://grafana.grafana/"
}
