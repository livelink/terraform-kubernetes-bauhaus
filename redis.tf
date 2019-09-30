resource "kubernetes_service" "redis" {
  metadata {
    name      = "redis"
    namespace = var.namespace
  }

  spec {
    selector = {
      k8s-app = kubernetes_deployment.redis.metadata[0].name
    }

    port {
      port        = 6379
      target_port = 6379
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_deployment" "redis" {
  metadata {
    name      = "redis"
    namespace = kubernetes_namespace.namespace.metadata[0].name

    labels = {
      k8s-app = "redis"
    }
  }

  spec {
    replicas = var.redis_replicas

    selector {
      match_labels = {
        k8s-app = "redis"
      }
    }

    template {
      metadata {
        labels = {
          k8s-app = "redis"
        }
      }

      spec {
        container {
          image = "redis:${var.redis_version}"
          name  = "${var.client_name}-${var.environment}-redis"
        }
      }
    }
  }
}

