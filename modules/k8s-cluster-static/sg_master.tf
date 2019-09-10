resource "aws_security_group" "k8s_master" {
  name        = "Kubernetes Master"
  description = "Control traffic to/from the Kubernetes Master instance(s)"
  vpc_id      = "${var.vpc_id}"
}

# Self-referential ingress
resource aws_security_group_rule "allow_etcd_from_k8s_master_to_self" {
  security_group_id        = aws_security_group.k8s_master.id
  type                     = "ingress"
  from_port                = 2379
  to_port                  = 2380
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.k8s_master.id
}

resource aws_security_group_rule "allow_kubelet_api_from_k8s_master_to_self" {
  security_group_id        = aws_security_group.k8s_master.id
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.k8s_master.id
}

resource aws_security_group_rule "allow_kube_scheduler_from_k8s_master_to_self" {
  security_group_id        = aws_security_group.k8s_master.id
  type                     = "ingress"
  from_port                = 10251
  to_port                  = 10251
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.k8s_master.id
}

resource aws_security_group_rule "allow_kube_controller_manager_from_k8s_master_to_self" {
  security_group_id        = aws_security_group.k8s_master.id
  type                     = "ingress"
  from_port                = 10252
  to_port                  = 10252
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.k8s_master.id
}

# Bastion ingress
resource aws_security_group_rule "allow_ssh_from_bastion_to_k8s_master" {
  security_group_id        = aws_security_group.k8s_master.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
}

# Worker ingress
resource aws_security_group_rule "allow_api_from_k8s_worker_to_k8s_master" {
  security_group_id        = aws_security_group.k8s_master.id
  type                     = "ingress"
  from_port                = 6443
  to_port                  = 6443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.k8s_worker.id
}

resource aws_security_group_rule "allow_etcd_from_k8s_worker_to_k8s_master" {
  security_group_id        = aws_security_group.k8s_master.id
  type                     = "ingress"
  from_port                = 2379
  to_port                  = 2380
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.k8s_worker.id
}

# General ingress
resource aws_security_group_rule "allow_api_from_bastion_to_k8s_master" {
  security_group_id        = aws_security_group.k8s_master.id
  type                     = "ingress"
  from_port                = 6443
  to_port                  = 6443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
}

resource aws_security_group_rule "allow_api_from_lb_to_k8s_master" {
  security_group_id        = aws_security_group.k8s_master.id
  type                     = "ingress"
  from_port                = 6443
  to_port                  = 6443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.k8s_lb.id
}
