
data "exoscale_compute_template" "ubuntu" {
    zone = var.zone_default
    name = "Linux Ubuntu 20.04 LTS 64-bit"
}

resource "exoscale_instance_pool" "instancepool" {
    description = "Instancepool for sprint1"
    zone = var.zone_default
    name = "ip1"
    template_id = data.exoscale_compute_template.ubuntu.id
    service_offering = "micro"
    size = 2
    disk_size = 10
    security_group_ids = [exoscale_security_group.min_ruleset.id]
    user_data = file("nginx.sh")
}