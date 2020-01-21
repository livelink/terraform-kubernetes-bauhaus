resource "kubernetes_stateful_set" "bauhaus" {
  metadata {
    name      = local.instance_name
    namespace = local.namespace

    labels = {
      "app.kubernetes.io/name"    = local.instance_name
      "app.kubernetes.io/part-of" = "bauhaus"
    }
  }

  spec {
    replicas               = var.replicas
    revision_history_limit = var.revision_history_limit

    selector {
      match_labels = {
        "app.kubernetes.io/name"    = local.instance_name
        "app.kubernetes.io/part-of" = "bauhaus"
      }
    }

    service_name = kubernetes_service.bauhaus.metadata[0].name

    update_strategy {
      type = "RollingUpdate"

      rolling_update {
        partition = 1
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/name"    = local.instance_name
          "app.kubernetes.io/part-of" = "bauhaus"
        }
      }

      spec {
        volume {
          name = "config"

          config_map {
            name = kubernetes_config_map.bauhaus.metadata[0].name
          }
        }

        volume {
          name = "pod-shared"

          empty_dir {
            medium = "Memory"
          }
        }

        image_pull_secrets {
          name = local.docker_secret
        }

        container {
          name              = "bauhaus-web"
          image             = "livelink/bauhaus:${var.bauhaus_version}"
          image_pull_policy = "Always"

          port {
            container_port = "8080"
            name           = "bauhaus-web"
            protocol       = "TCP"
          }

          volume_mount {
            name       = "config"
            mount_path = "/usr/src/config"
          }

          env {
            name  = "MEMCACHED_SERVERS"
            value = join(",", module.memcache.servers)
          }

          env {
            name  = "USE_SSL"
            value = "true"
          }

          resources {
            limits {
              cpu    = var.bh_resources["server"]["limits"]["cpu"]
              memory = var.bh_resources["server"]["limits"]["memory"]
            }

            requests {
              cpu    = var.bh_resources["server"]["requests"]["cpu"]
              memory = var.bh_resources["server"]["requests"]["memory"]
            }
          }

          readiness_probe {
            http_get {
              path = "/check"
              port = 8080
            }
          }
        }

        container {
          name              = "bauhaus-processor"
          image             = "livelink/bauhaus:${var.bauhaus_version}"
          image_pull_policy = "Always"

          command = [
            "/usr/src/bin/bauhaus-env",
            "/usr/src/bin/bauhaus-processor",
          ]

          resources {
            limits {
              cpu    = var.bh_resources["processor"]["limits"]["cpu"]
              memory = var.bh_resources["processor"]["limits"]["memory"]
            }

            requests {
              cpu    = var.bh_resources["processor"]["requests"]["cpu"]
              memory = var.bh_resources["processor"]["requests"]["memory"]
            }
          }

          env {
            name  = "MEMCACHED_SERVERS"
            value = join(",", module.memcache.servers)
          }

          volume_mount {
            name       = "config"
            mount_path = "/usr/src/config"
          }

          volume_mount {
            name       = "pod-shared"
            mount_path = "/usr/src/tmp"
          }
        }

        container {
          name              = "bauhaus-fetcher"
          image             = "livelink/bauhaus:${var.bauhaus_version}"
          image_pull_policy = "Always"

          command = [
            "/usr/src/bin/bauhaus-env",
            "/usr/src/bin/bauhaus-fetcher",
          ]
          env {
            name  = "MEMCACHED_SERVERS"
            value = join(",", module.memcache.servers)
          }
          volume_mount {
            name       = "config"
            mount_path = "/usr/src/config"
          }

          volume_mount {
            name       = "pod-shared"
            mount_path = "/usr/src/tmp"
          }

          resources {
            limits {
              cpu    = var.bh_resources["fetcher"]["limits"]["cpu"]
              memory = var.bh_resources["fetcher"]["limits"]["memory"]
            }

            requests {
              cpu    = var.bh_resources["fetcher"]["requests"]["cpu"]
              memory = var.bh_resources["fetcher"]["requests"]["memory"]
            }
          }
        }
      }
    }
  }
}
