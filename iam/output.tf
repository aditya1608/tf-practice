output "login_password" {
  value = aws_iam_user_login_profile.aditya.password
  sensitive = true
}

output "access_key_id" {
    value = aws_iam_access_key.aditya.id
    sensitive = true
}

output "secret_key" {
    value = aws_iam_access_key.aditya.secret
    sensitive = true
}