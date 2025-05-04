resource "hcloud_ssh_key" "user_manager" {
  name       = "${local.name}-manager"
  public_key = var.user_manager_ssh_pub
}

resource "hcloud_ssh_key" "user_deploy" {
  name       = "${local.name}-deploy"
  public_key = var.user_deploy_ssh_pub
}