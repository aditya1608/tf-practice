provider "aws" {
    region = "ap-south-1"  
}

resource "aws_instance" "adi" {
    ami = "ami-0327f51db613d7bd2"
    instance_type = "t2.micro"
    key_name = "aws_key"

    provisioner "file" {
        source = "./script.sh"
        destination = "/tmp/script.sh"      
    }

    provisioner "remote-exec" {
        inline = [ 
            "sudo bash /tmp/script.sh"
        ]

        connection {
            type = "ssh"
            user = "ec2-user"
            private_key = file("./aws_key.pem")
            host = self.public_ip
        }      
    }

    provisioner "local-exec" {
        command = "echo 'Hurray! Instance Launched: ${self.public_ip}' > new.txt"      
    }
}