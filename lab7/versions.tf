terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
      version = "~> 2.3.0"
    }
  }
}

provider "azapi" {
}