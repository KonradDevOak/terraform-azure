output "application_name" {
  description = "The name of the application"
  value       = var.application_name
}

output "environment_prefix" {
  description = "The environment prefix"
  value       = local.environment_prefix
}

output "suffix" {
  description = "The suffix"
  value       = random_string.suffix.result
}
