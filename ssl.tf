resource google_compute_managed_ssl_certificate bauhaus {
  provider = google-beta

  name = "bauhaus-${var.environment}-${var.client_name}-${var.namespace}-${var.instance}"

  managed {
    domains = ["bauhaus-${var.instance}.${var.environment}.${var.client_name}.${data.terraform_remote_state.dns.outputs.domain}."]
  }
}
