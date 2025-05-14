variable "application_name" {
  type = string
}

variable "environment_name" {
  type = string
}

# regions for rg
# https://github.com/claranet/terraform-azurerm-regions/blob/master/regions.tf
variable "primary_location" {
  type = string
}
