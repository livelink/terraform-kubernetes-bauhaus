resource "random_string" "config_name" {
  length      = 8
  special     = false
  min_lower   = 2
  upper       = false
  min_numeric = 2
  keepers = {
    "bauhaus.json" = data.null_data_source.bauhaus_json.outputs["bauhaus_json"]
    "redis.yml"    = data.null_data_source.redis_yml.outputs["redis_yml"]
  }
}

resource "kubernetes_config_map" "bauhaus" {
  metadata {
    name      = "${local.instance_name}-${random_string.config_name.result}"
    namespace = local.namespace
  }

  data = {
    "bauhaus.json" = data.null_data_source.bauhaus_json.outputs["bauhaus_json"]
    "redis.yml"    = data.null_data_source.redis_yml.outputs["redis_yml"]
  }
}

