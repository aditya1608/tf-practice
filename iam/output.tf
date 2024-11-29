output "login_password" {
  value = aws_iam_user_login_profile.adi.password
}

output "access_key_id" {
    value = aws_iam_access_key.adi.id
    sensitive = true
}

output "secret_key" {
    value = aws_iam_access_key.adi.secret
    sensitive = true
}