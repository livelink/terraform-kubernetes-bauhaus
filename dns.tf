resource "dns_a_record_set" "bauhaus" {
  zone = "${var.client_name}.${data.terraform_remote_state.dns.outputs.domain}."
  name = "bauhaus-${var.environment}-${var.instance}"

  addresses = [
    google_compute_global_address.bauhaus.address
  ]
}
