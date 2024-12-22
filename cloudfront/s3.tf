resource "aws_s3_bucket" "mb" {
    bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "mbow" {
  bucket = aws_s3_bucket.mb.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "mba" {
    bucket = aws_s3_bucket.mb.id
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false  
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