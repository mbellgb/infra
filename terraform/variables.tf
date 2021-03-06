variable "do_token" {
  description = "DigitalOcean API token"
}

variable "cloudflare_email" {
  description = "Email address for cloudflare"
}

variable "cloudflare_api_token" {
  description = "API token for cloudflare"
}

variable "mc_server_key" {
  description = "Minecraft server private key"
}

variable "mc_server_key_pub" {
  description = "Minecraft server public key"
}

variable "dns_record_ttl" {
  description = "Default TTL for DNS records"
  default     = 3600
}

variable "le_email" {
  description = "Let's Encrypt email"
}

variable "github_token" {
  description = "Token to authenticate with GitHub"
}

variable "gcp_credentials_encoded" {
  description = "Base64-encoded Google Cloud credentials"
}

variable "gcp_project" {
  description = "Google Cloud Platform project"
}

variable "gcp_region" {
  description = "Google Cloud Platform region"
}
