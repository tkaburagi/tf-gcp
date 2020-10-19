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