data "digitalocean_images" "ubuntu" {
  filter {
    key    = "distribution"
    values = ["${var.distribution}"]
  }
  filter {
    key    = "regions"
    values = ["${var.server_region}"]
  }
  filter {
    key      = "slug"
    match_by = "re"
    values   = ["${var.distribution}-${var.distro_version}"]
  }
}

data "digitalocean_sizes" "main" {
  filter {
    key    = "vcpus"
    values = ["${var.server_vcpus}"]
  }
  filter {
    key    = "memory"
    values = ["${var.server_memory}"]
  }
  filter {
    key    = "regions"
    values = ["${var.server_region}"]
  }
  filter {
    key    = "regions"
    values = ["${var.server_region}"]
  }
  filter {
    key    = "price_monthly"
    values = ["${var.server_monthly_cost}"]
  }
}

data "digitalocean_ssh_key" "key" {
  name = var.ssh_key_name
}
