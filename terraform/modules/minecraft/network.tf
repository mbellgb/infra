
resource "digitalocean_loadbalancer" "mc_server" {
  name   = "mc-server"
  region = local.region

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"

    certificate_id = digitalocean_certificate.craft.id
  }

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 80
    target_protocol = "http"

    certificate_id = digitalocean_certificate.craft.id
  }

  forwarding_rule {
    // SSH
    entry_port      = 2568
    entry_protocol  = "tcp"
    target_port     = 22
    target_protocol = "tcp"
  }

  forwarding_rule {
    entry_port     = 25565
    entry_protocol = "tcp"

    target_port     = 25565
    target_protocol = "tcp"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  redirect_http_to_https = true

  droplet_ids = [digitalocean_droplet.mc_server.id]
}

resource "digitalocean_firewall" "mcserver" {
  name        = "web-ssh-only"
  droplet_ids = [digitalocean_droplet.mc_server.id]

  inbound_rule {
    protocol   = "tcp"
    port_range = "22"
    # may be restricted if I cba to set up a bastion.
    source_addresses = ["0.0.0.0/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = [digitalocean_loadbalancer.mc_server.ip]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = [digitalocean_loadbalancer.mc_server.ip]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "25565"
    source_addresses = [digitalocean_loadbalancer.mc_server.ip]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
}

resource "digitalocean_certificate" "craft" {
  name    = "craft-cert"
  type    = "lets_encrypt"
  domains = ["craft.bell.wtf"]
}
