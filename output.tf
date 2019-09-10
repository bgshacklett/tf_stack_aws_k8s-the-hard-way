output "k8s_bastion_endpoint" {
  value = module.k8s.bastion_endpoint
}

output "k8s_master_endpoint" {
  value = module.k8s.master_endpoint
}

output "k8s_worker_endpoint" {
  value = module.k8s.worker_endpoint
}

output "k8s_api_endpoint" {
  value = module.k8s.api_endpoint
}
