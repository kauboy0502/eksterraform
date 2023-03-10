resource "kubernetes_namespace" "myns" {
metadata {
  name = "myapp"
}
    
  }


resource "kubernetes_deployment" "nginx-deployment" {
  metadata {
    name = "front-end-app"
    labels = {
      app = "frontendapp"
    }
    namespace = kubernetes_namespace.myns.metadata.0.name
  }

  spec {
    replicas = var.nginx-replicas

    selector {
      match_labels = {
        app = "frontendapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontendapp"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "nginx-app"

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
          "node-group" = "public"
        }
       }
    }
  
  }
}

resource "kubernetes_service" "front-end-svc" {
  metadata {
    name = "front-end-app-svc"
    namespace = kubernetes_namespace.myns.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.nginx-deployment.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
  depends_on = [
    kubernetes_deployment.nginx-deployment
  ]
}