environment_name = "test"
instance_count   = 7
regions          = ["us-east-1", "us-west-2"]
region_instance_count = {
  "us-east-1" = 2
  "us-west-2" = 3
}
region_set = ["us-east-1", "us-west-2"]
sku_settings = {
  kind = "P"
  tier = "Business"
}
