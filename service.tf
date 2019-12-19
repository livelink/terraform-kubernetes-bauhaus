resource "kubernetes_service" "bauhaus" {
  metadata {
    name      = local.instance_name
    namespace = local.namespace

    labels = {
      "app.kubernetes.io/name" = local.instance_name
      "app.kubernetes.io/part-of" = "bauhaus"
    }
  }

  spec {
    selector = {
      "app.kubernetes.io/name" = local.instance_name
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
