# resource "aws_security_group" "bastion_sg" {
#   name = "bastion_sg"
#   description = "Allow SSH from MyIP"
#   vpc_id      = aws_vpc.tt.id

#   # Ingress rules (Inbound traffic)
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["106.213.81.128/32"] # Allow SSH from anywhere (use cautiously!)
#   }

#   # Egress rules (Outbound traffic)
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1" # All protocols
#     cidr_blocks = ["0.0.0.0/0"] # Allow outbound traffic to anywhere
#   }

#   tags = {
#     Name = "bastion-security-group"
#   }
# }

# resource "aws_instance" "bastion" {
#     ami = "ami-0dee22c13ea7a9a67"
#     instance_type = "t2.micro"
#     key_name = "aws_key"
#     subnet_id = aws_subnet.public1.id
#     vpc_security_group_ids = [ aws_security_group.bastion_sg.id ]

  
# }

