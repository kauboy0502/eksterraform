resource "kubernetes_ingress_v1" "my_ingress" {
  metadata {
    name = "my-ingress"
    namespace = kubernetes_deployment.nginx-deployment.metadata.0.namespace
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"

    }
  }

  spec {


    rule {
      http {
        path {
          backend {
            service {
              name = kubernetes_service.front-end-svc.metadata.0.name
              port {
                number = var.service_port
              }
            }
          }

          path = "/"
        }

        
      }
    }
  }
}