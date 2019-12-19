data "null_data_source" "redis_yml" {
  inputs = {
    "redis_yml" = <<EOF
---
:host: ${module.bauhaus-redis.dns}
:port: 6379
  
EOF

  }
}

