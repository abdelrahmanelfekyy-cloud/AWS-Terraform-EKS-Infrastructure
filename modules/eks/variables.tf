variable "environment" { 
    type = string 
    }
variable "vpc_id" { 
    type = string 
    }
variable "private_subnet_ids" { 
    type = list(string) 
    }
variable "cluster_sg_id" { 
    type = string 
    }
variable "nodes_sg_id" { 
    type = string 
    }
variable "key_name" { 
    type = string 
    }