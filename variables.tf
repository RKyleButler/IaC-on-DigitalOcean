variable "do_token" {
  description = "DigitalOcean API Personal Access Token"
  type        = string
  sensitive   = true
}

variable "ssh_key_name" {
  description = "The name of the SSH key as it appears in your DigitalOcean account"
  type        = string
  default     = "my-laptop-key"
}

variable "region" {
  description = "DigitalOcean region slug"
  type        = string
  default     = "nyc3"
}
