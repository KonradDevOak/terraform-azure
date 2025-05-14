terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      # version = "= 3.6.3"
      # version = "~> 3.6.3"
      # version = ">= 3.6.3"
      version = "~> 3.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # required_version = ">= 1.3.0"
}
