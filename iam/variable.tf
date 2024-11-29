variable "policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

variable "password_policy_arn" {
  default = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

variable "username" {
  description = "Enter UserName"
}
