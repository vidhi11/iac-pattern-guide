provider "ibm" {
  generation         = 2
  region             = "us-south"
}

variable "ssh_key_name" {}

data "ibm_is_ssh_key" "iac_shared_ssh_key" {
  name       = var.ssh_key_name
}

output "id" {
  value = data.ibm_is_ssh_key.iac_shared_ssh_key.id
}
output "ibm_cloud_url" {
  value = data.ibm_is_ssh_key.iac_shared_ssh_key.resource_controller_url
}
