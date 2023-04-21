#!/bin/bash

# Creates a script that waits for cloud-init to complete
# This is remotely executed by Terraform.
tee -a /tmp/cloud_init_complete.sh << END
#!/bin/bash
while [ ! -f /var/lib/cloud/instance/boot-finished ]; do
  echo -e "\033[1;36mWaiting for cloud-init to complete..."
  sleep 1
done
END
chmod +x /tmp/cloud_init_complete.sh

# Perform system updates and install dependencies 
sudo apt-get update && sudo apt-get -y upgrade
sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
sudo chmod a+x /usr/local/bin/yq

# Install K3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik" sh -

# Prepare the k3s.yaml for download.  Allows user to access the cluster remotely
PUBLIC_IP=$(curl ifconfig.co)
export PUBLIC_IP
K3S_URL="https://${PUBLIC_IP}:6443"
export K3S_URL
yq -i '.clusters[0].cluster.server = strenv(K3S_URL)' /etc/rancher/k3s/k3s.yaml
