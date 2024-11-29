provider "aws" {
    region = "ap-south-1"
}

resource "aws_s3_bucket" "mb" {
    bucket = var.bucket_name
    
    tags = {
        Name = "My Bucket"
        Environment = "Dev"
    }
}

resource "aws_s3_bucket_acl" "mb" {
  bucket = aws_s3_bucket.mb.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "mb" {
  bucket = aws_s3_bucket.mb.id
  versioning_configuration {
    status = "Disabled"
  }
}