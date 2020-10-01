variable "ssh_pub" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAbh5ocMyAn1QsFPdxsh1CktFlKtHVNHdSX9uuW2N+b0c8x/zWlqLLw8cikckNPK/YBfm2Bak/WuRSzdqKEr13le9IAC53EgPa+cX1gNMqYLQ+J+O/Ggjeq/CmOwgXkwiCso5x3nA3DJFmJtAlHaINolnqju//M+GB3mt/yyOAtigod8WzjwYZ3NX+LxlUZZlz8sh72tBnLbIeC7zbG4POZQVpMLzR1xEjOnQTViu5feLic0PTdIveJ7wrV6Xh0GFClF+QC0tKi3F1MzIvWCmLSixw+qxMslpkz1sDQxnxpthQQNbxsE/D0CtPJ7ao+QiwDb2e3lKNpQLNubS6gKCr felix@DESKTOP-AVJJCBF"
}

resource "exoscale_ssh_keypair" "root" {
  name       = "root"
  public_key = var.ssh_pub
}

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
    key_pair = exoscale_ssh_keypair.root.name
}