locals {
  environment_prefix = "${var.application_name} - ${var.environment_name} - ${random_string.suffix.result}"
}
