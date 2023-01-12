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
    replicas = 2

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
      }
    }
  }
}