variable "exoscale_key" { type = string }
variable "exoscale_secret" { type = string }

terraform {
  required_providers {
    exoscale = {
        source = "terraform-providers/exoscale"
    }
  }
}

provider "exoscale" {
    key = var.exoscale_key
    secret = var.exoscale_secret
}

variable "zone_default" {
    type = string
    default = "at-vie-1"
}


locals {
  zone = var.zone_default
}

