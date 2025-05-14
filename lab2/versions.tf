terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.28.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.2"
    }
  }
}

// cli:
// az account show
// az account list
// export ARM_SUBSCRIPTION_ID="<your-subscription-id>"
provider "azurerm" {
  features {}
}
