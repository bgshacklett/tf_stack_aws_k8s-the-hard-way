resource "aws_security_group" "k8s_worker" {
  name        = "Kubernetes Worker"
  description = "Control traffic to/from the Kubernetes Worker instance(s)"
  vpc_id      = var.vpc_id
}

# Self-referential ingress
resource aws_security_group_rule "allow_all_from_k8s_worker_to_k8s_worker" {
  security_group_id        = aws_security_group.k8s_worker.id
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.k8s_worker.id
}

# Master ingress
resource aws_security_group_rule "allow_kublet_api_from_k8s_master_to_k8s_worker" {
  security_group_id        = aws_security_group.k8s_worker.id
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.k8s_master.id
}

resource aws_security_group_rule "allow_nodeport_ingress_from_k8s_master_to_k8s_worker" {
  security_group_id        = aws_security_group.k8s_worker.id
  type                     = "ingress"
  from_port                = 30000
  to_port                  = 32767
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.k8s_master.id
}

# Bastion ingress
resource aws_security_group_rule "allow_ssh_from_bastion_to_k8s_worker" {
  security_group_id        = aws_security_group.k8s_worker.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
}

# Other ingress
resource aws_security_group_rule "allow_nodeport_ingress_from_vpc_to_k8s_worker" {
  security_group_id = aws_security_group.k8s_worker.id
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "tcp"
  cidr_blocks       = [
                        "10.0.0.0/16",
                      ]
}
