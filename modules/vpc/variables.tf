variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    default = "10.10.0.0/21"
  
}

variable "vpc_sub_pub" {

     description = "CIDR block for the pub subnets"
     default = ["10.10.0.0/23","10.10.2.0/23"]
  
}



variable "vpc_sub_pri" {

     description = "CIDR block for the pri subnets"

     default = ["10.10.4.0/23","10.10.6.0/23"]
  
}

variable "opentointernet" {

default = "0.0.0.0/0"

}


variable "azones" {
  description = "Availability zones"
  default = ["us-east-1a","us-east-1b"]
}




