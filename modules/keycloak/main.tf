resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}
resource "kubernetes_service" "keycloak" {
  metadata {
    name      = "keycloak"
    namespace = var.namespace
    labels = {
      app = "keycloak"
    }
  }
  spec {
    type = "ClusterIP"
    selector = {
      app = "keycloak"
    }
    port {
      name        = "http"
      port        = 8080
      target_port = 8080
    }
  }
}
resource "kubernetes_deployment" "keycloak" {
  metadata {
    name      = "keycloak"
    namespace = var.namespace
    labels = {
      app = "keycloak"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "keycloak"
      }
    }
    template {
      metadata {
        labels = {
          app = "keycloak"
        }
      }
      spec {
        container {
          name  = "keycloak"
          image = "quay.io/keycloak/keycloak:21.0.1"
          args  = ["start-dev"]
          env {
            name  = "KEYCLOAK_ADMIN"
            value = "admin"
          }
          env {
            name  = "KEYCLOAK_ADMIN_PASSWORD"
            value = "admin"
          }
          env {
            name  = "KC_PROXY"
            value = "edge"
          }
          port {
            name           = "http"
            container_port = 8080
          }
          readiness_probe {
            http_get {
              path = "/realms/master"
              port = 8080
            }
          }
        }
      }
    }
  }
}
