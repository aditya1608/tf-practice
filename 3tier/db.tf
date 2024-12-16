resource "aws_security_group" "db_sg" {
  name = "db_sg"
  description = "DB sg"
  vpc_id      = aws_vpc.tt.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [ aws_security_group.app_sg.id ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow outbound traffic to anywhere
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp" 
    security_groups = [ aws_security_group.app_sg.id ] 
  }

  tags = {
    Name = "db-security-group"
  }
}

resource "aws_db_subnet_group" "db_subnet_grp" {
    name = "db-subnet-group"
    subnet_ids = [aws_subnet.private3.id, aws_subnet.private4.id]   
}

resource "aws_db_instance" "my-db" {
    identifier           = "my-db"
    allocated_storage    =  20
    db_name              = "mydb"
    engine               = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t3.micro"
    username             = "admin"
    password             = "admin123"
    parameter_group_name = "default.mysql8.0"
    multi_az             =  false
    skip_final_snapshot  =  true  
    publicly_accessible  =  false
    availability_zone    = "ap-south-1a"
    db_subnet_group_name =  aws_db_subnet_group.db_subnet_grp.name
    vpc_security_group_ids = [ aws_security_group.db_sg.id ]
}