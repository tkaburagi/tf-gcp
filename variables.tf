variable "gcp_key" {}
variable "machine_type" {}
variable "hello_tf_instance_count" {
    default = 1
}
variable "region" {
    default = "asia-northeast1"
}
variable "project" {}
variable "image" {}

variable "vault_url" {
    default = "https://releases.hashicorp.com/vault/1.3.0/vault_1.3.0_linux_amd64.zip"
}
variable "consul_url" {
    default = "https://releases.hashicorp.com/consul/1.6.2/consul_1.6.2_linux_amd64.zip"
}
variable "terraform_url" {
    default = "https://releases.hashicorp.com/terraform/0.12.16/terraform_0.12.16_linux_amd64.zip"
}
variable "nomad_url" {
    default = "https://releases.hashicorp.com/nomad/0.10.1/nomad_0.10.1_linux_amd64.zip"
}
variable "ubuntu_password" {
    default = "happy-hacking"
}

variable "static_ip" {
    default = "10.146.15.212"
}