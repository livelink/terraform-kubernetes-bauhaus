resource "google_compute_global_address" "bauhaus" {
  name = "bauhaus-${var.environment}-${var.client_name}"
}
