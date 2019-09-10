resource "aws_lb" "k8s_api" {
  name               = "k8s-api"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.k8s_lb.id]
  subnets            = var.public_subnet

  enable_deletion_protection = false

  tags = merge(
                local.common_tags,
                {},
              )
}

resource "aws_lb_target_group" "k8s_master" {
  name     = "k8s-master"
  port     = 6443
  protocol = "HTTPS"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "k8s_master" {
  count = length(aws_instance.master)

  target_group_arn = aws_lb_target_group.k8s_master.arn
  target_id        = element(aws_instance.master.*.id, count.index)
  port             = 6443
}
