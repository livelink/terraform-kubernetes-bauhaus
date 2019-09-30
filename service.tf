resource "kubernetes_service" "bauhaus" {
  metadata {
    name      = var.set_name
    namespace = kubernetes_namespace.namespace.metadata[0].name

    labels = {
      "app.kubernetes.io/name" = var.set_name
      "app.kubernetes.io/part-of" = "bauhaus"
    }
  }

  spec {
    selector = {
      "app.kubernetes.io/name" = var.set_name
      "app.kubernetes.io/part-of" = "bauhaus"
    }

    port {
      port        = var.ingress_port
      target_port = 8080
      name        = "bauhaus-web"
    }

    type = "NodePort"
  }
}

