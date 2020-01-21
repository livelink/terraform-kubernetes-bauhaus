module bauhaus-redis {
  source = "livelink/redis/kubernetes"

  client_name    = var.client_name
  environment    = var.environment
  replicas_count = var.redis_replicas
  namespace      = local.namespace
  service        = "bauhaus-queue"
  part_of        = local.instance_name

}
