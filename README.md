# Terraform Digital Ocean K3s Installer

Quickly create a Digital Ocean droplet that installs [K3s](https://k3s.io/), a lightweight Kubernetes distribution built for IoT and Edge Computing.  It is currently limited to a single virtual machine; however, it could be expanded to add additional nodes to the cluster.



**NOTE:** This is **NOT** intended for production environments. It is currently geared for temporary developer environments.



## Installation

### Requirements

- Terraform v1.4.5 (You should use [tfenv](https://github.com/tfutils/tfenv) if you aren't already)
- Digital Ocean API Token [link](https://cloud.digitalocean.com/account/api/tokens)
- Kubectl [link](https://kubernetes.io/docs/tasks/tools/)



### VM Creation Steps 

1. Run the command `terraform init` to install dependencies
2. Create a file called `terraform.tfvars` and assign values to the required variables outlined in the table below.  You can use environment variables or the CLI if you wish.  Steps are outlined [here](https://developer.hashicorp.com/terraform/language/values/variables#assigning-values-to-root-module-variables)
3. Run `terraform validate` to make sure there are no errors in the configuration
4. Run `terraform apply`


### Connecting to the Cluster

1. Upon completion, there should be a new file called `k3s.yaml`.
2. Open your favorite terminal program and navigate to the directory containing the `k3s.yaml` file
3. Run the following command to use the `k3s.yaml` for connecting via Kubectl: `export KUBECONFIG="k3s.yaml"`
4. Run `kubectl get nodes` to verify that you are able to connect to the cluster.



## Variables

| Variable Name (* is required) | Description                                                  | Default Value |
| ----------------------------- | ------------------------------------------------------------ | ------------- |
| do_token*                     | Digital Ocean API Token. Generate one here: https://cloud.digitalocean.com/account/api/tokens |               |
| distribution                  | Preferred Linux Distribution                                 | Ubuntu        |
| distro_version                | Linux Distribution Version. Ubuntu should use XX-YY format.  | 20-04         |
| server_region                 | Digital Ocean Datacenter Region                              | Nyc1          |
| k3s_server_name*              | Name for the K3s Server. Only valid hostname characters are allowed. (a-z, A-Z, 0-9, . and -) |               |
| server_vcpus                  | The number of CPUs allocated to Droplets of this size.       | 4             |
| server_memory                 | The amount of RAM allocated to Droplets created of this size. The value is measured in megabytes. | 8192          |
| server_monthly_cost           | The monthly cost of Droplets created in this size if they are kept for an entire month. The value is measured in US dollars. | 48            |
| ssh_key_name*                 | The name of the SSH key you uploaded to Digital Ocean.  It will be used to access the server. |               |
| private_ssh_key_path*         | Path to the private key used to access the server. Required to download the k3s.yaml configuration |               |