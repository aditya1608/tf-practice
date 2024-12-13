resource "aws_security_group" "app_sg" {
  name = "app_sg"
  description = "backend sg"
  vpc_id      = aws_vpc.tt.id

  # Ingress rules (Inbound traffic)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [ aws_security_group.bastion_sg.id ]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    security_groups = [ aws_security_group.web_sg.id ]
  }

  # ingress {
  #   from_port   = 3306
  #   to_port     = 3306
  #   protocol    = "tcp"
  #   security_groups = [ aws_security_group.db_sg.id ]
  # }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp" 
    security_groups = [ aws_security_group.db_sg.id ] 
  }

  tags = {
    Name = "app-security-group"
  }
}

resource "aws_launch_template" "app-lt" {
    name = "app-lt"
    image_id = "ami-0dee22c13ea7a9a67"
    instance_type = "t2.micro"
    key_name = "aws_key"
    vpc_security_group_ids = [ aws_security_group.app_sg.id ]
    #user_data = filebase64("./mysql.sh")
}

resource "aws_autoscaling_group" "app-asg" {
    max_size = 5
    min_size = 2
    desired_capacity = 2
    launch_template {
        id = aws_launch_template.app-lt.id
        version = aws_launch_template.app-lt.latest_version
    }  
    vpc_zone_identifier = [ aws_subnet.private1.id, aws_subnet.private2.id]
    target_group_arns = [aws_lb_target_group.tg-app.arn]
}

resource "aws_lb_target_group" "tg-app" {
  name     = "tg-app"
  port     = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.tt.id
  # health_check {
  #   path = "/"
  #   port = 80
  #   protocol = "HTTP"
  # }
}

resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app_sg.id]
  subnets            = [aws_subnet.private1.id, aws_subnet.private2.id]
}

resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-app.arn
  }
}


