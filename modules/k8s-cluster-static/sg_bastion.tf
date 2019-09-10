resource "aws_security_group" "bastion" {
  name        = "Bastion"
  description = "Control traffic to/from the bastion instance"
  vpc_id      = "${var.vpc_id}"
}

resource aws_security_group_rule "allow_ssh_from_all_to_bastion" {
  security_group_id = aws_security_group.bastion.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [
                        "0.0.0.0/0",
                      ] 
}

resource aws_security_group_rule "allow_ssh_from_bastion_to_vpc" {
  security_group_id = aws_security_group.bastion.id
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [
                        local.vpc_cidr_range,
                      ]
}
