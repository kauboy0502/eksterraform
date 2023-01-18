output "load_balancer_hostname" {
  value = kubernetes_ingress_v1.my_ingress.status.0.load_balancer.0.ingress.0.hostname
}