terraform {

}

provider "kubernetes" {
  config_path    = var.kube-path
  config_context = var.kube-context
}

provider "helm" {
  kubernetes {
    config_path    = var.kube-path
    config_context = var.kube-context
  }
}
