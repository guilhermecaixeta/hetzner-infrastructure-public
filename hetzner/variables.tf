# Token Variable Definition
variable "hetzner_token" {
  type = string
}

# Name variable definition
variable "app-name" {
  type    = string
  default = "sandbox"
}

# Defining a variable source OS image for an instance
variable "image" {
  type    = string
  default = "debian-12"
}

# Definition of an instance type variable depending on the choice of tariff
variable "server_type" {
  type    = string
  default = "cx22"
}

# Definition of the region in which the instance will be created
variable "location" {
  type    = string
  default = "nbg1"
}

variable "datacenter" {
  type = string
  default = "nbg1-dc3"
}

variable "ip_range" {
  type    = string
  default = "10.0.0.0/16"
}

variable "ip_subnet" {
  type    = string
  default = "10.0.0.0/24"
}

variable "ip_gateway" {
  type    = string
  default = "10.0.0.1"
}

variable "ip_web" {
  type    = string
  default = "10.0.0.2"
}

variable "ip_range_web" {
  default = [
    "10.0.0.5",
    "10.0.0.6",
    "10.0.0.7"
  ]
}

variable "ip_accessories" {
  type    = string
  default = "10.0.0.3"
}

variable "ip_range_accessories" {
  default = [
    "10.0.0.8",
    "10.0.0.9",
    "10.0.0.10"
  ]
}

# UFW

variable "ufw_tcp_ports" {
  type    = string
  default = "443,80"
}

# SSH
#Default port
variable "ssh_port" {
  default = "22"
}

# Pub key for default user
variable "user_manager" {}
variable "user_manager_password" {}

variable "user_manager_ssh_pub" {}
variable "user_manager_ssh_key" {}

# Pub key for deploy user
variable "user_deploy" {}
variable "user_deploy_password" {}

variable "user_deploy_ssh_pub" {}
variable "user_deploy_ssh_key" {}