# terraform plan -var "application_name=blog" -var "environment_name=dev"
// it works too
/* Goku :) */
variable "application_name" {
  type = string

  validation {
    condition     = length(var.application_name) <= 30
    error_message = "The application name must be 30 characters or less."
  }
}

variable "environment_name" {
  type = string
}

variable "api_key" {
  type      = string
  sensitive = true
}

variable "enabled" {
  type = bool
}

variable "instance_count" {
  type    = number
  default = 1

  validation {
    condition     = var.instance_count >= local.min_nodes && var.instance_count <= local.max_nodes && var.instance_count % 2 != 0
    error_message = "The instance count must be between 5 and 9 and never even"
  }
}

variable "regions" {
  type = list(string)
}

variable "region_instance_count" {
  type = map(number)
}

variable "region_set" {
  type = set(string)
}

variable "sku_settings" {
  type = object({
    kind = string
    tier = string
  })

}
