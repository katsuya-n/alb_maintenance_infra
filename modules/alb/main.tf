resource "aws_lb" "alb" {
  // name_prefixだと文字数が多すぎたので直書き
  name               = "lightkun-test-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_alb_id]
  subnets            = [var.subnet_az_1a_id, var.subnet_az_1b_id]

  enable_deletion_protection = false


  tags = {
    Environment = "dev"
  }
}