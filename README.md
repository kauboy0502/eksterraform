# Terraform Advance Assignment
​
## **TASK :**
Create a 3-tier application environment using Terraform with the following requirements:
 1. It has 1 VPC with a CIDR range 10.10.0.0/21
 2. It has  2 private subnets where each subnet has 25% of the IPs
 3. It has  2 public subnets where each subnet has 25% of the IPs
 4. It has NAT gateways for the private subnets
 5. It has internet gateways for the public subnets
 6. Build an EKS cluster across public and private subnets
     - Built with HPA and autoscaling ( 50% reserved instances + 50% spot instances)
    - Inbuilt security and credential management.
    - Ingress controller with Nginx for the presentation layer 
    1. It has a front-end or presentation tier with:
        - A public load balancer that allows all traffic that allows requests on port 80
        - Nginix with atleast 2 replica sets running dockers listening on port 80
    2. It has a back-end or application tier (API) with:
        - A load balancer that is only accessible from the presentation tier’s ec2s
        - Any application server that can host PHP applications (Apache for e.g. 3 replica sets) running dockers listening on port 80
    3. It has a database or data tier with the following:
        - An RDS running the latest version
        - Accessible only from the application tier’s ec2s
        - Credentials are stored in secrets manager:
          - Username: admin
          - Password: <auto-generated>
    4. There should be a bastion server in a public subnet for SSH tunneling to all the docker containers (Nice to have).
​
----
​
​
## Requirements
​
| Name                                                                         | Version |
| ---------------------------------------------------------------------------- | ------- |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                      | ~> 4.0  |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.16.1  |
​
## Providers
​
No providers.
​
## Modules
​
| Name                                          | Source        | Version |
| --------------------------------------------- | ------------- | ------- |
| <a name="module_eks"></a> [eks](#module\_eks) | ./modules/eks | n/a     |
| <a name="module_k8s"></a> [k8s](#module\_k8s) | ./modules/k8s | n/a     |
| <a name="module_rds"></a> [rds](#module\_rds) | ./modules/rds | n/a     |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a     |
​
## Resources
​
No resources.
​
## Inputs
​
| Name                                                                                   | Description                                         | Type     | Default                  | Required |
| -------------------------------------------------------------------------------------- | --------------------------------------------------- | -------- | ------------------------ | :------: |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region)                     | AWS region in which infrastructure need to be setup | `string` | `"us-east-1"`            |    no    |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | n/a                                                 | `string` | `"terraform_assignment"` |    no    |
| <a name="input_rds_attributes"></a> [rds\_attributes](#input\_rds\_attributes)         | RDS module variables                                | `any`    | n/a                      |   yes    |
​
## Outputs
​
No outputs.