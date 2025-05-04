resource "terraform_data" "accessories_provisioner" {
  connection {
    type                = "ssh"
    host                = var.ip_accessories
    port                = var.ssh_port
    user                = var.user_deploy
    private_key         = var.user_deploy_ssh_key
    timeout             = "1m"
    agent               = false
    bastion_host        = hcloud_server.web.ipv4_address
    bastion_port        = var.ssh_port
    bastion_user        = var.user_deploy
    bastion_private_key = var.user_deploy_ssh_key
  }

  provisioner "local-exec" {
    command = "sleep 60" # Wait until all services being up and running
  }

  provisioner "remote-exec" {
    when       = create
    on_failure = continue
    inline     = ["sudo cloud-init clean --logs --reboot"]
  }

  depends_on = [hcloud_server.accessories]
}
