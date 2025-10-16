terraform {
  backend "gcs" {
    bucket = "tfstate-chile"
    prefix = "gcp-linux-vm"
  }
}
