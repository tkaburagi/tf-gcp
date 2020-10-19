terraform {
  required_version = " 0.12.6"
}

provider "google" {
	credentials = var.gcp_key
	project     = var.project
	region      = var.region
}

resource "google_compute_instance" "vm_instance" {
	name = "hashinstance-${count.index}"
	machine_type = var.machine_type
	count = var.hello_tf_instance_count
	zone = "asia-northeast1-a"
	tags = google_compute_firewall.default.source_tags
	network_interface {
		network_ip = "10.146.15.210"
	}
	labels = {
		owner = "kabu",
		ttl = "100"
	}
	boot_disk {
		initialize_params {
			image = var.image
		}
	}

	network_interface {
		# A default network is created for all GCP projects
		network       = "default"
		access_config {
		}
	}

	metadata_startup_script = data.template_file.init.rendered

}

data "template_file" "init" {
	template = file("setup.sh")
	vars = {
		vault_url = var.vault_url
		consul_url = var.consul_url
		nomad_url = var.nomad_url
		terraform_url = var.terraform_url
		ubuntu_password = var.ubuntu_password
	}
}

resource "google_compute_firewall" "default" {
	name    = "tf-playground-firewall"
	network = google_compute_network.tf-playground-network.name

	allow {
		protocol = "icmp"
	}

	allow {
		protocol = "tcp"
		ports    = ["80", "8080", "22" ,"443", "4646", "8200", "8500", "9701", "9200"]
	}

	source_tags = ["hashi"]
}

resource "google_compute_network" "tf-playground-network" {
	name = "tf-playground-network"
}