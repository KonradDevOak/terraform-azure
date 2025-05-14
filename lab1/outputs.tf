output "application_name" {
  value = module.tf-fundamentals.application_name
}

output "environment_prefix" {
  value = module.tf-fundamentals.environment_prefix
}

output "suffix" {
  value = module.tf-fundamentals.suffix
}

output "api_key" {
  value     = var.api_key
  sensitive = true
}

output "region_set" {
  value = var.regions[0]
}

output "primary_region_instance" {
  value = var.region_instance_count[var.regions[0]]
}

output "kind" {
  value = var.sku_settings.kind
}

output "alpha" {
  value = module.alpha.random_string
}

output "bravo" {
  value = module.bravo.random_string
}


output "random_string" {
  value = module.rando.random_string
}
