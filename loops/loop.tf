provider "aws" {
    region = "us-east-1"  
}

variable "instance_type" {
    default = {
        small = "t2.small"
        micro = "t2.micro"
        medium = "t2.medium"
    }  
}

output "instance_type" {
    value = [for key, type in var.instance_type: "${key}"]
  
}