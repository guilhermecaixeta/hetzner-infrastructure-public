locals {
  ssh_config = <<EOF
    Host accessories_deploy
        HostName ${var.ip_accessories}
        User ${var.user_deploy}
        Port ${var.ssh_port}
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/accessories_deploy_ed25519  

    Host accessories_manager
      HostName ${var.ip_accessories}
      User ${var.user_manager}
      Port ${var.ssh_port}
      PreferredAuthentications publickey
      IdentityFile ~/.ssh/accessories_manager_ed25519
    EOF
}

data "cloudinit_config" "cloud_config_web" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    merge_type   = "list(append)+dict(no_replace, recurse_list)"
    content = templatefile(
      "${path.module}/cloud-init/web.yml",
      {
        ip_accessories = var.ip_accessories
        ip_range       = var.ip_range
        ssh_config     = local.ssh_config
        ssh_port       = var.ssh_port
    })
  }

  part {
    content_type = "text/cloud-config"
    merge_type   = "list(append)+dict(no_replace, recurse_list)"
    content = yamlencode({
      "write_files" : [
        {
          "path" : "/root/.ssh/config"
          "encoding" : "text/plain"
          "content" : "${local.ssh_config}"
          "permissions" : "0600"
        },
        {
          "path" : "/root/.ssh/${var.user_deploy}_ed25519"
          "encoding" : "text/plain"
          "content" : "${var.user_deploy_ssh_key}"
          "permissions" : "0600"
        },
        {
          "path" : "/root/.ssh/${var.user_manager}_ed25519"
          "encoding" : "text/plain"
          "content" : "${var.user_manager_ssh_key}"
          "permissions" : "0600"
        }
    ] })
  }

  part {
    content_type = "text/cloud-config"
    merge_type   = "list(append)+dict(no_replace, recurse_list)"
    content = templatefile("${path.module}/cloud-init/base.yml",
      {
        user_deploy           = var.user_deploy
        user_deploy_ssh_pub   = var.user_deploy_ssh_pub
        user_deploy_password  = var.user_deploy_password
        user_manager          = var.user_manager
        user_manager_ssh_pub  = var.user_manager_ssh_pub
        user_manager_password = var.user_manager_password
        ufw_tcp_ports         = var.ufw_tcp_ports
        ssh_port              = var.ssh_port
        ip_web                = var.ip_web
        ip_accessories        = var.ip_accessories
      }
    )
  }
}

data "cloudinit_config" "cloud_config_accessories" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/cloud-init/acessories.yml",
      {
        ip_range      = var.ip_range
        ip_subnet      = var.ip_subnet
        ip_gateway     = var.ip_gateway
        ip_accessories = var.ip_accessories
    })
    merge_type = "list(append)+dict(no_replace, recurse_list)"
  }

  part {
    content_type = "text/cloud-config"
    merge_type   = "list(append)+dict(no_replace, recurse_list)"
    content = templatefile("${path.module}/cloud-init/base.yml",
      {
        user_deploy           = var.user_deploy
        user_deploy_ssh_pub   = var.user_deploy_ssh_pub
        user_deploy_password  = var.user_deploy_password
        user_manager          = var.user_manager
        user_manager_ssh_pub  = var.user_manager_ssh_pub
        user_manager_password = var.user_manager_password
        ufw_tcp_ports         = "${var.ufw_tcp_ports},5432,6379"
        ssh_port              = var.ssh_port
        ip_web                = var.ip_web
        ip_accessories        = var.ip_accessories
      }
    )
  }
}
