output "bastion_endpoint" {
  value = aws_instance.bastion.public_dns
}

output "master_endpoint" {
  value = aws_instance.master.*.private_dns
}

output "worker_endpoint" {
  value = aws_instance.worker.*.private_dns
}

output "api_endpoint" {
  value = aws_lb.k8s_api.dns_name
}
