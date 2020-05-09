resource "ibm_is_lb" "iac_app_lb" {
  name    = "${var.project_name}-${var.environment}-lb"
  subnets = [ibm_is_subnet.iac_app_subnet.id]
}

resource "ibm_is_lb_listener" "iac_app_lb_listener" {
  lb       = ibm_is_lb.iac_app_lb.id
  port     = var.port
  protocol = "http"
}

resource "ibm_is_lb_pool" "iac_app_lb_pool" {
  name           = "${var.project_name}-${var.environment}-lb-pool"
  lb             = ibm_is_lb.iac_app_lb.id
  algorithm      = "round_robin"
  protocol       = "http"
  health_delay   = 60
  health_retries = 5
  health_timeout = 30
  health_type    = "http"
}

resource "ibm_is_lb_pool_member" "iac_app_lb_pool_mem" {
  lb             = ibm_is_lb.iac_app_lb.id
  pool           = ibm_is_lb_pool.iac_app_lb_pool.id
  port           = var.port
  target_address = ibm_is_instance.iac_app_instance[count.index].primary_network_interface.0.primary_ipv4_address
  weight         = 60
  count          = var.max_size
}
