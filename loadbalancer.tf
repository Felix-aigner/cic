resource "exoscale_nlb" "nlb" {
  name = "loadbalancer"
  description = "This is the Network Load Balancer for magnificent computing"
  zone = var.zone_default
}

resource "exoscale_nlb_service" "healthchecker" {
  zone = exoscale_nlb.nlb.zone
  name = "healthchecker"
  description = "healthcheck"
  nlb_id = exoscale_nlb.nlb.id
  instance_pool_id = exoscale_instance_pool.instancepool.id
  protocol = "tcp"
  port = 80
  target_port = 8080
  strategy = "round-robin"

  healthcheck {
    port = 8080
    mode = "http"
    uri = "/health"
    interval = 5
    timeout = 3
    retries = 1
  }
}
