resource "aws_s3_bucket" "mb" {
    bucket = var.bucket_name #bucket-public2025
}

resource "aws_s3_bucket_ownership_controls" "mbow" {
  bucket = aws_s3_bucket.mb.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "mbacl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.mbow
  ]

  bucket = aws_s3_bucket.mb.id
  acl    = "public-read"
}

resource "aws_s3_bucket_versioning" "mbv" {
    bucket = aws_s3_bucket.mb.id
    versioning_configuration {
        status = "Disabled"
    }
}

resource "aws_s3_object" "mbo" { 
    bucket = aws_s3_bucket.mb.id
    key = "index.html"
    source = "./index.html"
    acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "mbw" {
    bucket = aws_s3_bucket.mb.id
    index_document {
      suffix = "index.html"
    }  
}