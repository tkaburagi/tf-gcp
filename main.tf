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
	tags = google_compute_firewall.tf-playground.source_tags
	network_interface {
		subnetwork = "default"
		network_ip = var.static_ip
		access_config {
		}
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
		static_ip = var.static_ip
	}
}

resource "google_compute_firewall" "tf-playground" {
	name    = "tf-playground-firewall"
	network = "default"

	allow {
		protocol = "icmp"
	}

	allow {
		protocol = "tcp"
		ports    = ["80", "8080", "22" ,"443", "4646", "8200", "8500", "9701", "9200"]
	}

	source_tags = ["hashi"]
}
