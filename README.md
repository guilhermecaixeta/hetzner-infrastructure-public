# Infrastructure

#### *OBS: This repo is a copy from a personal project and does not reflect all changes in real time*

# Hetzner

## Project

This project aims to create a secure infrastructure for a small application on Hetzner Cloud. In order to achieve this, the project creates two linux vpc servers, one public and one private and configure them to forbidden any unauthorized access as well as blacklisting them.

### About the Servers

The decision to create two servers on the cheapest layer on Hetzner were to grant some secure for the application as well as for the data, said that the public server will host only the applications were no data storage is required. The private server will handle all data required to be persisted by a database, in order to both communicate a NAT gateway was configured allowing also the usage of the internet from the private server.

Both server uses distro Debian12

## Servers specification

| Type | VCPU | RAM | Disk Space | Primary IPV4 | TOTAL|
--- | --- | --- | --- | --- | ---
| CX22| 2 | 4GB | 40GB | YES |1|
| CX22| 2 | 4GB | 40GB | NO |1|

## Infrastructure Diagram
![alt text](https://github.com/guilhermecaixeta/hetzner-infrastructure/blob/main/documentation/infrastructure.png?raw=true)

## Terraform

All the infrastructure is managed by terraform, in order to deploy correctly the infrastructure there is some variable that must be informed.

Are they:

- hetzner_token: Token that gives access to provider deploy infra
- user_manager: User name responsible to manage the server from ssh access
- user_manager_password: password for user manager
- user_manager_ssh_pub: ssh public key
- user_manager_ssh_key: ssh private key
- user_deploy: Cloud user name responsible to manage the server from pipeline
- (Will be removed) user_deploy_password: user password
- user_deploy_ssh_pub: ssh public key
- user_deploy_ssh_key: ssh private key

# AWS

Complementary infrastructure

[WIP]

# Github Actions

This project has a working CI/CD structure that could be enabled by uncommenting the scripts.

Fell free to copy this repo!