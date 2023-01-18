resource "kubernetes_deployment" "apache-deployment" {
  metadata {
    name = "back-end-app"
    labels = {
      app = "backendapp"
    }
    namespace = kubernetes_namespace.myns.metadata.0.name
  }

  spec {
    replicas = var.http-replicas

    selector {
      match_labels = {
        app = "backendapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "backendapp"
        }
      }

      spec {
        container {
          image = "apache:latest"
          name  = "apache-app"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
        node_selector = {
          "node-group" = "private"
        }
       }
    }
  
  }
}

resource "kubernetes_service" "back-end-svc" {
  metadata {
    name = "back-end-app-lb-svc"
    namespace = kubernetes_namespace.myns.metadata.0.name
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-scheme" = "internal"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment.apache-deployment.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
  depends_on = [
    kubernetes_deployment.apache-deployment
  ]
}