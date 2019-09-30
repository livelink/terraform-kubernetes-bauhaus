data "null_data_source" "redis_yml" {
  inputs = {
    "redis_yml" = <<EOF
---
:host: redis.${kubernetes_namespace.namespace.metadata[0].name}.svc.cluster.local
:port: 6379
  
EOF

  }
}

