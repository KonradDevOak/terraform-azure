variable "application_name" {
}

variable "environment_name" {
}

variable "enabled" {
  type = bool
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
