provider "aws" {
    region = "ap-south-1"
}

resource "aws_s3_bucket" "mb" {
    bucket = var.bucket_name
    acl = "private" 
    versioning {
        enabled = false
    }

    tags = {
        Name = "My Bucket"
        Environment = "Dev"
    }
}