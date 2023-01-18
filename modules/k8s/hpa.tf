resource "kubernetes_horizontal_pod_autoscaler_v1" "eks_hpa" {
  metadata {
    name = "eks-hpa"
    namespace = kubernetes_namespace.myns.metadata.0.name
  }

  

  spec {
    max_replicas = 10
    min_replicas = 8

    scale_target_ref {
      kind = "Deployment"
      name = kubernetes_deployment.nginx-deployment.metadata.0.name
      
    }
  
    target_cpu_utilization_percentage = var.cpuutilizationpercentage

  }


}

