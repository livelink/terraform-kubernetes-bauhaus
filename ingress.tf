resource "kubernetes_ingress" "bauhaus" {
  metadata {
    name      = local.instance_name
    namespace = local.namespace


    annotations = {
      "kubernetes.io/ingress.global-static-ip-name" = google_compute_global_address.bauhaus.name
      "ingress.gcp.kubernetes.io/pre-shared-cert"   = google_compute_managed_ssl_certificate.bauhaus.name
    }
  }

  spec {
    backend {
      service_name = kubernetes_service.bauhaus.metadata.0.name
      service_port = var.ingress_port
    }

    rule {
      http {
        path {
          path = "/register"

          backend {
            service_name = kubernetes_service.bauhaus.metadata.0.name
            service_port = var.ingress_port
          }
        }
      }
    }

    rule {
      http {
        path {
          path = "/get/*"

          backend {
            service_name = kubernetes_service.bauhaus.metadata.0.name
            service_port = var.ingress_port
          }
        }
      }
    }
  }
}
