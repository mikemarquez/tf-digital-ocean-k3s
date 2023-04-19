resource "digitalocean_droplet" "k3s_main_server" {
  image     = data.digitalocean_images.ubuntu.images[0].slug
  name      = var.k3s_server_name
  region    = var.server_region
  size      = data.digitalocean_sizes.main.sizes[0].slug
  ssh_keys  = [data.digitalocean_ssh_key.key.id]
  user_data = file("k3s_installer.sh")
}

output "ready" {
  depends_on = [digitalocean_droplet.k3s_main_server]
  value      = <<EOT
  ==============================================================================
                         K3S INSTALLATION COMPLETE
  ==============================================================================
  You can access the main server via SSH:

  ssh -i PRIVATE_KEY_PATH root@${digitalocean_droplet.k3s_main_server.ipv4_address}

  To access the cluster from your local machine, run the following command:

  export KUBECONFIG=k3s.yaml

  NOTE: This will only be valid for a single terminal session. You will have to
  run this command again if you open a new terminal session.
  ==============================================================================
  EOT
}

resource "null_resource" "get_k3s_yaml" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = digitalocean_droplet.k3s_main_server.ipv4_address
      user        = "root"
      private_key = file(var.private_ssh_key_path)
    }

    inline = ["sleep 20 && /tmp/cloud_init_complete.sh"]
  }

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -i ${var.private_ssh_key_path} root@${digitalocean_droplet.k3s_main_server.ipv4_address}:/etc/rancher/k3s/k3s.yaml ."
  }
}
