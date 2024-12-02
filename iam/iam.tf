provider "aws" {
    region = "ap-south-1"
}

resource "aws_iam_user" "adi" {
    name = var.username
}

resource "aws_iam_access_key" "adi" {
    user = aws_iam_user.adi.name
}

resource "aws_iam_user_login_profile" "adi" {
    user = aws_iam_user.adi.name
    password = "Deshadi@1608"
    password_reset_required = true
}

resource "aws_iam_user_policy_attachment" "adi" {
    user = aws_iam_user.adi.name
    policy_arn = var.policy_arn
}

resource "aws_iam_user_policy_attachment" "adip" {
    user = aws_iam_user.adi.name
    policy_arn = var.password_policy_arn
}