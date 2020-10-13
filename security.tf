resource "exoscale_security_group" "min_ruleset" {
  name = "min_ruleset"
  description = "security group for sprint1"
}

resource "exoscale_security_group_rule" "http" {
  security_group_id = exoscale_security_group.min_ruleset.id
  type = "INGRESS"
  protocol = "tcp"
  cidr = "0.0.0.0/0"
  start_port = 8080
  end_port = 8080
}

resource "exoscale_security_group_rule" "ssh" {
  security_group_id = exoscale_security_group.min_ruleset.id
  type = "INGRESS"
  protocol = "tcp"
  cidr = "0.0.0.0/0"
  start_port = 22
  end_port = 22
}

