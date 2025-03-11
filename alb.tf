resource "aws_lb" "twot_alb" {
  name               = "twot-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["aws_security_group.alb_sg"]
  subnets            = ["aws_subnet.pubsub_1.id, aws_subnet.pubsub_2.id"]

  enable_deletion_protection = false

  tags = {
    name = "twot-alb"
  }
}

#Target group
resource "aws_lb_target_group" "twot_tg" {
  name     = "twot-tg"
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.twot_vpc.id
 
  health_check {
   enabled = true
   healthy_threshold = 5
   interval = 300
   path = "/"
   port = "traffic-port"
   protocol = "HTTP"
   matcher = "200"
   timeout = 30
   unhealthy_threshold = 3
 }
}

#Target group attachment
resource "aws_lb_target_group_attachment" "tg_attach1" {
  target_group_arn = aws_lb_target_group.twot_tg.arn
  target_id        = aws_instance.webserver1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "tg_attach2" {
  target_group_arn = aws_lb_target_group.twot_tg.arn
  target_id        = aws_instance.webserver2.id
  port             = 80
}

#Listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.twot_alb.arn
  port              = "80"
  protocol          = "HTTP"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.twot_tg.arn
  }
}
