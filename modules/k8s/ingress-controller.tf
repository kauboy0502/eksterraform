resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
 set {
    name = "nodeSelector.node-group"
    value = var.pubnodegrplabel
 }
  
    
  }
