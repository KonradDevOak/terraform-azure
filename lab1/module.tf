module "tf-fundamentals" {
  source                = "./modules/tf-fundamentals"
  application_name      = var.application_name
  environment_name      = var.environment_name
  regions               = var.regions
  region_instance_count = var.region_instance_count
  region_set            = var.region_set
  enabled               = var.enabled
}

module "alpha" {
  source  = "hashicorp/module/random"
  version = "1.0.0"
}

module "bravo" {
  source  = "hashicorp/module/random"
  version = "1.0.0"
}

module "rando" {
  source = "./modules/rando"
  length = 8
}

# module "regional-stamps" {
#   source = "./modules/regional-stamp"

#   count = length(local.regional-stamps)

#   region         = local.regional-stamps[count.index].region
#   name           = local.regional-stamps[count.index].name
#   min_node_count = local.regional-stamps[count.index].min_node_count
#   max_node_count = local.regional-stamps[count.index].max_node_count
# }


module "regional-stamps" {
  source = "./modules/regional-stamp"

  for_each = local.regional-stamps

  region         = each.value.region
  name           = each.key
  min_node_count = each.value.min_node_count
  max_node_count = each.value.max_node_count
}
