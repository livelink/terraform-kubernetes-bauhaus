variable "bauhaus_version" {
  default = "latest"
}

variable "revision_history_limit" {
  default = 5
}

variable "namespace" {
  default = "default"
}

variable "replicas" {
  default = 3
}

variable "environment" {
  default = "test"
}

variable "cloud_provider" {
  default = "gcp"
}

variable "client_name" {
  default = "livelink"
}

variable "redis_version" {
  default = "latest"
}

variable "redis_replicas" {
  default = "1"
}

variable "memcache_resource_limits" {
  default = {
    cpu    = "150m"
    memory = "256Mi"
  }
}

variable "memcache_resource_requests" {
  default = {
    cpu    = "50m"
    memory = "64Mi"
  }
}

variable "bh_resources" {
  default = {
    server = {
      limits = {
        cpu    = "150m"
        memory = "100Mi"
      }

      requests = {
        cpu    = "100m"
        memory = "64Mi"
      }
    }
    processor = {
      limits = {
        cpu    = "50m"
        memory = "100Mi"
      }

      requests = {
        cpu    = "50m"
        memory = "64Mi"
      }
    }
    fetcher = {
      limits = {
        cpu    = "50m"
        memory = "100Mi"
      }

      requests = {
        cpu    = "50m"
        memory = "64Mi"
      }
    }
  }
}
variable instance {
  description = "Name for my bauhaus"
  default     = "default"
}
variable "set_name" {
  description = "Name for the services and sets"
  default     = "bauhaus"
}

variable "ingress_port" {
  description = "TCP port for web inbound traffic"
  default     = 80
}

variable "manage_namespace" {
  default     = false
  description = "Whether or not this module manages the namespace"
}

variable "dice" {
  default = {
    enabled = false
  }
}
