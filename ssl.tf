resource "google_compute_managed_ssl_certificate" "bauhaus" {
  provider = "google-beta"

  name = "bauhaus-${var.environment}-${var.client_name}"

  managed {
    domains = ["bauhaus-${var.environment}.${var.client_name}.${data.terraform_remote_state.dns.outputs.domain}."]
  }
}
