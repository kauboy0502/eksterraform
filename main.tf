terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.49.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.16.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
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


module "vpckk" {
  source = "./modules/vpc"

}

module "eks" {
  source = "./modules/eks"
  pubsub = module.vpckk.pubsubnets
  prisub = module.vpckk.prisubnets
  depends_on = [
    module.vpckk
  ]
}

module "k8s"{
  source = "./modules/k8s"
  depends_on = [
    module.eks
  ]
}