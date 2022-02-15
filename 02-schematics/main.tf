provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region     = "us-south"
}
terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "~> 1.32.1"
    }
    template = {
      source = "hashicorp/template"
      version = ">= 2.2.0"
    }
  }
}

resource "ibm_is_instance" "iac_test_instance" {
  name    = "${var.project_name}-${var.environment}-instance"
  image   = "r006-14140f94-fcc4-11e9-96e7-a72723715315"
  profile = "cx2-2x4"

  primary_network_interface {
    name            = "eth1"
    subnet          = ibm_is_subnet.iac_test_subnet.id
    security_groups = [ibm_is_security_group.iac_test_security_group.id]
  }

  vpc  = ibm_is_vpc.iac_test_vpc.id
  zone = "us-south-1"
  keys = [var.public_key]

  user_data = <<-EOUD
              #!/bin/bash
              echo "Hello Beautiful World" > index.html
              nohup busybox httpd -f -p ${var.port} &
              EOUD

  tags = ["iac-${var.project_name}-${var.environment}"]
}
