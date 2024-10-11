terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.49.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.33.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

provider "aws" {
  region = "us-east-1"
   default_tags {
    tags = {
      Owner                                           = "Kaustubh K"
      "kubernetes.io/cluster/${var.clustername}" = "owned"
    }
}
}

provider "kubernetes" {
  host                   = module.eks.endpoint
  cluster_ca_certificate = base64decode(module.eks.kubeconfig-certificate-authority-data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.endpoint
    cluster_ca_certificate = base64decode(module.eks.kubeconfig-certificate-authority-data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}

provider "random" {
  
}




module "vpc" {
  source = "./modules/vpc"

}

module "eks" {
  source = "./modules/eks"
  pubsub = module.vpc.pubsubnets
  prisub = module.vpc.prisubnets
  depends_on = [
    module.vpc
  ]
}

module "k8s"{
  source = "./modules/k8s"
  depends_on = [
    module.eks,
    module.rds
  ]
}

module "rds" {
  source = "./modules/rds"
  sgs=module.vpc.security_group_ic
  dbsubgrp = module.vpc.prisubnets
  depends_on = [
    module.vpc
    
  ]
  
}

