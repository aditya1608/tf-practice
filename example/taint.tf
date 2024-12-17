provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "adi" {
    ami = "ami-0e2c8caa4b6378d8c"
    instance_type = "t2.micro"
    key_name = "aws_key"
    tags = {
        Name = "adi"
    }
  
}