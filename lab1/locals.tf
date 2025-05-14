locals {
  # regional-stamps = [
  #   {
  #     region         = "us-east-1"
  #     name           = "regionA"
  #     min_node_count = 1
  #     max_node_count = 3
  #   },
  #   {
  #     region         = "us-west-1"
  #     name           = "regionB"
  #     min_node_count = 2
  #     max_node_count = 4
  #   }
  # ]
  regional-stamps = {
    "regionA" = {
      region         = "us-east-1"
      min_node_count = 1
      max_node_count = 3
    },
    "regionB" = {
      region         = "us-west-1"
      min_node_count = 2
      max_node_count = 4
    }
  }
}
