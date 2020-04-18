provider "digitalocean" {
  token = var.do_token
}

module "minecraft" {
  source            = "./modules/minecraft"
  mc_server_key     = var.mc_server_key
  mc_server_key_pub = var.mc_server_key_pub
}