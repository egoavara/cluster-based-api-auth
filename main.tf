module "istio" {
  source = "./modules/istio"
}

module "prometheus" {
  source = "./modules/prometheus"
  depends_on = [
    module.istio
  ]
}

module "kiali" {
  source = "./modules/kiali"
  depends_on = [
    module.istio,
    module.prometheus,
  ]
}


module "grafana" {
  source = "./modules/grafana"
  depends_on = [
    module.istio,
    module.prometheus,
  ]
}


module "keycloak" {
  source = "./modules/keycloak"
  depends_on = [
    module.istio
  ]
}
