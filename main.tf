resource "digitalocean_droplet" "web_server" {
  image  = "ubuntu-22-04-x64"
  name   = "my-iac-server-01"
  region = var.region
  size   = "s-1vcpu-1gb" # The smallest standard Droplet
  
  # Automatically injects your SSH key for login
  ssh_keys = [data.digitalocean_ssh_key.main.id]

  # Optional but recommended features
  monitoring = true
  ipv6       = true
}

# Output the IP address once the Droplet is created
output "droplet_ip" {
  value = digitalocean_droplet.web_server.ipv4_address
}
