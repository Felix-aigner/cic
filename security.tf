resource "exoscale_security_group" "min_ruleset" {
  name = "min_ruleset"
  description = "security group for sprint1"
}

resource "exoscale_security_group_rule" "http" {
  security_group_id = exoscale_security_group.min_ruleset.id
  type = "INGRESS"
  protocol = "tcp"
  cidr = "0.0.0.0/0"
  start_port = 80
  end_port = 80
}

resource "exoscale_security_group_rule" "ssh" {
  security_group_id = exoscale_security_group.min_ruleset.id
  type = "INGRESS"
  protocol = "tcp"
  cidr = "0.0.0.0/0"
  start_port = 22
  end_port = 22
}

variable "ssh_rsa_pub" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAbh5ocMyAn1QsFPdxsh1CktFlKtHVNHdSX9uuW2N+b0c8x/zWlqLLw8cikckNPK/YBfm2Bak/WuRSzdqKEr13le9IAC53EgPa+cX1gNMqYLQ+J+O/Ggjeq/CmOwgXkwiCso5x3nA3DJFmJtAlHaINolnqju//M+GB3mt/yyOAtigod8WzjwYZ3NX+LxlUZZlz8sh72tBnLbIeC7zbG4POZQVpMLzR1xEjOnQTViu5feLic0PTdIveJ7wrV6Xh0GFClF+QC0tKi3F1MzIvWCmLSixw+qxMslpkz1sDQxnxpthQQNbxsE/D0CtPJ7ao+QiwDb2e3lKNpQLNubS6gKCr felix@DESKTOP-AVJJCBF"
}