variable dbsubgrp {
    type = list(string)

}

variable "sgs" {
    
  
}

variable engine {
    default = "postgres"
}

variable "engine_version" {
    default = "10.14"
  
}

variable "username" {
    default = "rdsadmin"
  
}

variable "instanceclass" {
  default = "db.t3.micro"
}

