locals {
  name = "${var.app-name}-${random_string.name.result}"
}

resource "random_string" "name" {
  length  = 6
  special = false
  upper   = false
}

resource "hcloud_placement_group" "placement-group" {
  name = "${local.name}-group"
  type = "spread"
  labels = {
    type       = "group"
    managed_by = "terraform"
    group      = var.app-name
  }
}

resource "hcloud_server" "web" {                                       # Create a server
  name               = "${local.name}-web"                             # Name server
  image              = var.image                                       # Basic image
  server_type        = var.server_type                                 # Instance type
  datacenter         = var.datacenter                                  # Datacenter
  backups            = "false"                                         # Enable backups
  user_data          = data.cloudinit_config.cloud_config_web.rendered # The script that works when you start
  placement_group_id = hcloud_placement_group.placement-group.id       # The placement group
  firewall_ids       = [hcloud_firewall.web-firewall.id]
  ssh_keys           = [hcloud_ssh_key.user_manager.id, hcloud_ssh_key.user_deploy.id]

  network {
    network_id = hcloud_network.network.id
    ip         = var.ip_web
    alias_ips  = var.ip_range_web
  }

  public_net {
    ipv4_enabled = true
    ipv4         = hcloud_primary_ip.web.id
    ipv6_enabled = false
  }

  labels = {
    type       = "web"
    managed_by = "terraform"
    group      = var.app-name
  }

  depends_on = [
    hcloud_network.network
  ]
}

resource "hcloud_server" "accessories" {                                       # Create a server
  name               = "${local.name}-accessories"                             # Name server
  image              = var.image                                               # Basic image
  server_type        = var.server_type                                         # Instance type
  location           = var.location                                            # Region
  backups            = "false"                                                 # Enable backups
  user_data          = data.cloudinit_config.cloud_config_accessories.rendered # The script that works when you start
  placement_group_id = hcloud_placement_group.placement-group.id               # The placement group
  firewall_ids       = [hcloud_firewall.accessories-firewall.id]
  ssh_keys           = [hcloud_ssh_key.user_manager.id, hcloud_ssh_key.user_deploy.id]

  public_net {
    ipv4_enabled = false
    ipv6_enabled = false
  }

  network {
    network_id = hcloud_network.network.id
    ip         = var.ip_accessories
    alias_ips  = var.ip_range_accessories
  }

  labels = {
    type       = "accessories"
    managed_by = "terraform"
    group      = var.app-name
  }

  depends_on = [hcloud_network.network, hcloud_network_route.private-network, hcloud_server.web]
}
