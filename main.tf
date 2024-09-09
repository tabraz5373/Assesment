# main.tf

provider "google" {
  project = var.project
  region  = var.region
}

variable "project" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "network_name" {
  description = "VPC network name"
  type        = string
  default     = "my-vpc-network"
}

variable "subnet_public" {
  description = "Public subnet CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_private" {
  description = "Private subnet CIDR"
  type        = string
  default     = "10.0.2.0/24"
}

# VPC and Subnets
resource "google_compute_network" "vpc_network" {
  name = var.network_name
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = "public-subnet"
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = var.subnet_public
  region        = var.region
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "private-subnet"
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = var.subnet_private
  region        = var.region
}

# Firewall Rules
resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}

# Compute Engine Instance
resource "google_compute_instance" "web_instance" {
  name         = "web-instance"
  machine_type = "e2-micro"
  tags         = ["web-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network            = google_compute_network.vpc_network.id
    subnetwork         = google_compute_subnetwork.public_subnet.id
    access_config {}  # Enables external IP
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl start nginx
    systemctl enable nginx
  EOF

  service_account {
    email  = google_service_account.default.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata = {
    enable-oslogin = "TRUE"
  }
}

# Service Account
resource "google_service_account" "default" {
  account_id   = "web-server-sa"
  display_name = "Web Server Service Account"
}

# Outputs
output "instance_ip" {
  description = "Public IP of the web instance"
  value       = google_compute_instance.web_instance.network_interface[0].access_config[0].nat_ip
}
