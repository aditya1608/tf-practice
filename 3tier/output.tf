output "lb_endpoint" {
    value = aws_lb.web_lb.dns_name
}

output "db_endpoint" {
    value = aws_db_instance.my-db.endpoint
}

