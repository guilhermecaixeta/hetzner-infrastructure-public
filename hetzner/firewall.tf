resource "hcloud_firewall" "web-firewall" {
  name = "${local.name}-web-firewall"
  rule {
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  
  rule {
    direction = "in"
    protocol  = "udp"
    port      = 53
    source_ips = [
      var.ip_web,
      "0.0.0.0/0",
      "::/0"
    ]    
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = 80
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = 443
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = var.ssh_port
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_firewall" "accessories-firewall" {
  name = "${local.name}-accessories-firewall"
  rule {
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = var.ssh_port
    source_ips = [
      var.ip_web,
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "udp"
    port      = 53
    source_ips = [
      var.ip_web,
      "0.0.0.0/0",
      "::/0"
    ]    
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = 5432
    source_ips = [
      var.ip_web,
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = 6379
    source_ips = [
      var.ip_web,
      "0.0.0.0/0",
      "::/0"
    ]
  }  
}
