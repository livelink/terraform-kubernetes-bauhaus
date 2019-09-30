data "null_data_source" "bauhaus_json" {
  inputs = {
    "bauhaus_json" = <<EOF
{
  "use_ssl": "yes",
  "cache_root": "/usr/src",
  "memcache-servers": [ "${join("\",\"", module.memcache.servers)}" ]
}
  
EOF

  }
}

