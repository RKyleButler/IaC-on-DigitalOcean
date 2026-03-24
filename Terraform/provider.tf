terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

# Fetches the ID of an SSH key already uploaded to your DO account
data "digitalocean_ssh_key" "main" {
  name = var.ssh_key_name
}
