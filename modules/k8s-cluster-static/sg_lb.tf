resource "aws_security_group" "k8s_lb" {
  name        = "Kubernetes API Load Balancer"
  description = "Control traffic to/from the Kubernetes API Load Balancer"
  vpc_id      = "${var.vpc_id}"
}

# General ingress
resource aws_security_group_rule "allow_api_from_all_to_k8s_lb" {
  security_group_id = aws_security_group.k8s_lb.id
  type              = "ingress"
  from_port         = 6443
  to_port           = 6443
  protocol          = "tcp"
  cidr_blocks       = [
                        "0.0.0.0/0",
                      ]
}
