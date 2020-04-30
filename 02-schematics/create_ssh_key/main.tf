provider "ibm" {
  generation         = 2
  region             = "us-south"
}

variable "public_key_file"  { default = "~/.ssh/id_rsa.pub" }
locals {
  public_key    = file(pathexpand(var.public_key_file))
}

resource "ibm_is_ssh_key" "iac_test_key" {
  name       = "schematics-test-key"
  public_key = local.public_key
}

output "id" {
  value = ibm_is_ssh_key.iac_test_key.id
}
output "ibm_cloud_url" {
  value = ibm_is_ssh_key.iac_test_key.resource_controller_url
}
