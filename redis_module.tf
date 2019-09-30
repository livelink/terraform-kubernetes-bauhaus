#module redis {
#  source = "/Users/stuartharland/code/terraform-kubernetes-redis"

#  kubernetes_namespace = kubernetes_namespace.namespace.metadata[0].name

#  master_resource_limits = {
#    cpu    = "500m"
#    memory = "2Gi"
#  }

#  slave_replica_count  = 2

#  use_password = false
#}
