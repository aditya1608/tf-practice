provider "aws" {
    region = "ap-south-1"
}

resource "aws_iam_user" "adi" {
    name = "adi"
}

resource "aws_iam_access_key" "adi" {
    user = aws_iam_user.adi.name
}

resource "aws_iam_user_login_profile" "adi" {
    user = aws_iam_user.adi.name
    password_reset_required = true
}

resource "aws_iam_user_policy_attachment" "adi" {
    user = aws_iam_user.adi.name
    policy_arn = var.policy_arn
}