resource "ibm_resource_instance" "iac_app_cos_instance" {
  name     = "cos-instance"
  service  = "cloud-object-storage"
  plan     = "standard"
  location = "global"
}

resource "ibm_cos_bucket" "iac_app_cos_bucket" {
  bucket_name          = "${var.project_name}-${var.environment}-bucket"
  resource_instance_id = ibm_resource_instance.iac_app_cos_instance.id
  single_site_location = "ams03"
  storage_class        = "standard"
}

resource "ibm_is_volume" "iac_app_volume" {
  name     = "${var.project_name}-${var.environment}-volume"
  profile  = "10iops-tier"
  zone     = "us-south-1"
  capacity = 100
}
