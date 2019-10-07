module "memcache" {
  source    = "essjayhch/memcache/kubernetes"
  version   = "0.2.1"
  replicas  = 3
  namespace = kubernetes_namespace.namespace.metadata[0].name
  resource_limits = var.memcache_resource_limits
  resource_requests = var.memcache_resource_requests
  run_as = 65534
  fs_group = 65534
}

