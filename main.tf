terraform {
  required_version = " 0.12.6"
}

provider "google" {
	credentials = var.gcp_key
	project     = "se-kabu"
	region      = "asia-northeast-1"
}