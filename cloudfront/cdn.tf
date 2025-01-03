# locals {
#   s3_origin_id = "myS3Origin"
# }

# resource "aws_cloudfront_distribution" "cdn" {
#     origin {
#         domain_name = aws_s3_bucket_website_configuration.mbw.website_endpoint
#         origin_id = local.s3_origin_id
#         origin_shield {
#             enabled = false          
#         }    
#     }

#     default_cache_behavior {
#         allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#         cached_methods   = ["GET", "HEAD"]
#         target_origin_id = local.s3_origin_id
#         viewer_protocol_policy = "allow-all"
#         min_ttl                = 0
#         default_ttl            = 3600
#         max_ttl                = 86400
#   }

#   # Cache behavior with precedence 0
#   ordered_cache_behavior {
#     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#     cached_methods   = ["GET", "HEAD", "OPTIONS"]
#     target_origin_id = local.s3_origin_id

#     forwarded_values {
#       query_string = false
#       headers      = ["Origin"]

#       cookies {
#         forward = "none"
#       }
#     }

#     min_ttl                = 0
#     default_ttl            = 86400
#     max_ttl                = 31536000
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#   } 
    
  
# }