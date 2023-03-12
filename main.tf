module "istio" {
  source = "./modules/istio"
}
module "kubernetes-dashboard" {
  source = "./modules/kubernetes-dashboard"
}

module "grafana" {
  source = "./modules/grafana"
}

module "keycloak" {
  source = "./modules/keycloak"
}

module "prometheus" {
  source = "./modules/prometheus"
}
