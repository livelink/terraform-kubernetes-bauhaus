output "dns" {
  value = "${dns_a_record_set.bauhaus.name}.${var.client_name}.${data.terraform_remote_state.dns.outputs.domain}"
}
