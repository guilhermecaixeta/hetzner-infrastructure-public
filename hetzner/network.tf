resource "hcloud_network" "network" {
  name     = "${local.name}-network"
  ip_range = var.ip_range
  labels = {
    type       = "network"
    managed_by = "terraform"
    group      = var.app-name
  }
}

resource "hcloud_network_subnet" "network-subnet" {
  type         = "server"
  network_id   = hcloud_network.network.id
  network_zone = "eu-central"
  ip_range     = var.ip_subnet
}

resource "hcloud_network_route" "private-network" {
  network_id  = hcloud_network.network.id
  destination = "0.0.0.0/0"
  gateway     = var.ip_web
}

resource "hcloud_primary_ip" "web" {
  name          = "${local.name}-primary-ip"
  type          = "ipv4"
  datacenter    = var.datacenter
  assignee_type = "server"
  auto_delete   = false

  labels = {
    type       = "primary-ip"
    managed_by = "terraform"
    group      = var.app-name
  }
}
