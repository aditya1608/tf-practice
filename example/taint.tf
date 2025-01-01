terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use a compatible AWS provider version
    }
  }

  required_version = ">= 1.3.0" # Minimum Terraform version
}

provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "adi" {
    ami = "ami-053b12d3152c0cc71"
    instance_type = "t2.micro"
    key_name = "aws_key"
    tags = {
        Name = "adi"
    }
}
