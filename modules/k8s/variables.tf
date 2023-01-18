variable "nginx-replicas" {
    default = 2
    description = "Replicas for nginx front end"
  
}

variable "pubnodegrplabel" {
       default = "public"
            
        }
    

variable "service_port" {
    default = 80
  
}    

variable "http-replicas" {
    default = 3
  
}

variable "cpuutilizationpercentage" {
  default = 75
}