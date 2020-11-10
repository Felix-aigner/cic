

resource "exoscale_compute" "Monitor" {
  display_name = "monitor"
  zone = "at-vie-1"
  template_id = data.exoscale_compute_template.ubuntu.id
  size = "micro"
  disk_size = 10
  key_pair = exoscale_ssh_keypair.root.name
  security_group_ids = [exoscale_security_group.prometheus_security_group.id]
  user_data = file("userdata/prometheus_instance.sh")
}
