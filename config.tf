resource "kubernetes_config_map" "bauhaus" {
  metadata {
    name      = "config"
    namespace = local.namespace
  }

  data = {
    "bauhaus.json" = data.null_data_source.bauhaus_json.outputs["bauhaus_json"]
    "redis.yml"    = data.null_data_source.redis_yml.outputs["redis_yml"]
  }
}

