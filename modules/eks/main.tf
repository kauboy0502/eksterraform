resource "aws_eks_cluster" "eks_app" {
  name     = "eks-app"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = var.pubsub
    endpoint_private_access = false
    endpoint_public_access = true

  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}

resource "aws_eks_node_group" "pubnodegrp" {
  cluster_name    = aws_eks_cluster.eks_app.name
  node_group_name = "eks_pub_grp"
  node_role_arn   = aws_iam_role.eks_nodegrp_role.arn
  subnet_ids      = var.pubsub
  labels = {
    "node-group" = "public"
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
  capacity_type = "ON_DEMAND"
  instance_types = [var.instance]

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_node_group" "prinodegrp" {
  cluster_name    = aws_eks_cluster.eks_app.name
  node_group_name = "eks_pri_grp"
  node_role_arn   = aws_iam_role.eks_nodegrp_role.arn
  subnet_ids      = var.prisub
   labels = {
    "node-group" = "private"
  }
  

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
  capacity_type = "ON_DEMAND"
  instance_types = [var.instance]

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

