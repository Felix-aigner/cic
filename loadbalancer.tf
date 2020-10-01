resource "exoscale_nlb" "nlb" {
  name = "sprint1loadbalancer"
  description = "This is the Network Load Balancer for magnificent computing"
  zone = var.zone_default
}

resource "exoscale_nlb_service" "healthchecker" {
  zone = exoscale_nlb.nlb.zone
  name = "healthchecker"
  description = "http healthchecker"
  nlb_id = exoscale_nlb.nlb.id
  instance_pool_id = exoscale_instance_pool.instancepool.id
  protocol = "tcp"
  port = 80
  target_port = 80
  strategy = "round-robin"

  healthcheck {
    port = 80
    mode = "http"
    uri = "/"
    interval = 5
    timeout = 3
    retries = 1
  }
}