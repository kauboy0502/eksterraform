output "endpoint" {
  value = aws_eks_cluster.eks_app.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_app.certificate_authority[0].data
}

# output "client_key" {
#   value =  aws_eks_cluster.eks_app.client_key[0].data 
# }

# output "client_cert" {
#   value =  aws_eks_cluster.eks_app.client_certificate[0].data 
# }

output "cluster_name" {
    value = aws_eks_cluster.eks_app.name
  
}
