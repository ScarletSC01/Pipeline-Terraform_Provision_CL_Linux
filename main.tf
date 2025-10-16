resource "google_compute_instance" "vm_instance" {
  name         = "linux-instance-${var.country}"
  machine_type = var.vm_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = lookup({
        "ubuntu-2004-lts" = "ubuntu-os-cloud/ubuntu-2004-lts"
        "ubuntu-2204-lts" = "ubuntu-os-cloud/ubuntu-2204-lts"
        "debian-12"       = "debian-cloud/debian-12"
      }, var.os_type, "ubuntu-os-cloud/ubuntu-2204-lts")

      size = var.disk_size
    }
  }

  network_interface {
    network    = var.network_interface
    subnetwork = var.network_subnet
    access_config {
      nat_ip = var.enable_private_ip == "yes" ? null : "EPHEMERAL"
    }
  }

  metadata = {
    startup-script = var.gitclone_bbk
  }

  tags = split(",", var.fw_rules)
}
