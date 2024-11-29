provider "aws" {
    region = "ap-south-1"
}

resource "aws_s3_bucket" "mb1" {
    bucket = var.bucket_name1
    tags = {
        Name = "Dev Bucket"
        Environment = "Dev"
    }
}

resource "aws_s3_bucket" "mb2" {
    bucket = var.bucket_name2
    tags = {
        Name = "Test Bucket"
        Environment = "Test"
    }
}

resource "aws_s3_bucket_versioning" "mb1" {
    bucket = aws_s3_bucket.mb1.id
    versioning_configuration {
        status = "Disabled"
    }
}

resource "aws_s3_bucket_versioning" "mb2" {
    bucket = aws_s3_bucket.mb2.id
    versioning_configuration {
        status = "Disabled"
    }
}

resource "aws_s3_object" "mb" { 
    bucket = aws_s3_bucket.mb1.id
    key = "my-script"
    source = "./copy_file.sh"
}