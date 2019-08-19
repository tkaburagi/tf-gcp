terraform {
  required_version = " 0.12.6"
}

provider "google" {
	credentials = var.gcp_key
	project     = "se-kabu"
	region      = "asia-northeast1"
}

resource "google_compute_instance" "vm_instance" {
	name         = "terraform-instance"
	machine_type = "f1-micro"
	zone = "asia-northeast1-a"
	labels = {
		owner = "kabu",
		ttl = "100"
	}
	boot_disk {
		initialize_params {
			image = "debian-cloud/debian-9"
		}
	}

	network_interface {
		# A default network is created for all GCP projects
		network       = "default"
		access_config {
		}
	}
}