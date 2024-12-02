locals {
  common_tags = {
    company     = var.company
    environment = var.environment
  }

  naming_prefix = "${var.company}-${var.environment}"
}

