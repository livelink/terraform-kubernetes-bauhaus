resource "dns_a_record_set" "bauhaus" {
  zone = "${var.client_name}.${data.terraform_remote_state.dns.outputs.domain}."
  name = "bauhaus-${var.environment}"

  addresses = [
    kubernetes_ingress.bauhaus.load_balancer_ingress.0.ip
  ]
}
