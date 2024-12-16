resource "aws_security_group" "app_sg" {
  name = "app_sg"
  description = "backend sg"
  vpc_id      = aws_vpc.tt.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [ aws_security_group.web_sg.id ]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    security_groups = [ aws_security_group.web_sg.id ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    Name = "app-security-group"
  }
}

resource "aws_launch_template" "app-lt" {
    name = "app-lt"
    image_id = var.image_id
    instance_type = var.instance_type
    key_name = var.key_pair
    vpc_security_group_ids = [ aws_security_group.app_sg.id ]
}

resource "aws_autoscaling_group" "app-asg" {
    name = "app-asg" 
    max_size = 4
    min_size = 1
    desired_capacity = 1
    launch_template {
        id = aws_launch_template.app-lt.id
    }  
    vpc_zone_identifier = [ aws_subnet.private1.id, aws_subnet.private2.id]
    target_group_arns = [aws_lb_target_group.tg-app.arn]
}

resource "aws_lb_target_group" "tg-app" {
  name     = "tg-app"
  port     = 8080
  protocol = "HTTP"
  vpc_id = aws_vpc.tt.id
  health_check {
    path = "/"
    port = 8080
    protocol = "HTTP"
  }
}

resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
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


