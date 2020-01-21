resource "google_compute_global_address" "bauhaus" {
  name = "bauhaus-${var.environment}-${var.namespace}-${var.client_name}-${var.instance}"
}
