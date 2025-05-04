output "web_server_status" {
  value = hcloud_server.web.status
}

output "web_server_ip" {
  value = hcloud_server.web.ipv4_address
}

output "accessories_server_status" {
  value = hcloud_server.accessories.status
}