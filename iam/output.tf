output "login_password" {
  value = aws_iam_user_login_profile.aditya.password
}

output "access_key_id" {
    value = aws_iam_access_key.aditya.id
}

output "secret_key" {
    value = aws_iam_access_key.aditya.secret
}