provider "aws" {
    region = "ap-south-1"
}

resource "aws_iam_user" "aditya" {
  name = "aditya"
}

resource "aws_iam_access_key" "aditya" {
    user = aws_iam_user.aditya.name
}

resource "aws_iam_user_login_profile" "aditya" {
    user = aws_iam_user.aditya.name
    password_length = 10
}

resource "aws_iam_user_policy_attachment" "aditya" {
    user = aws_iam_user.aditya.name
    policy_arn = var.policy_arn
}