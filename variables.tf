variable "do_token" {
  type        = string
  sensitive   = true
  description = "Digital Ocean API Token. Generate one here: https://cloud.digitalocean.com/account/api/tokens"
}

variable "distribution" {
  type        = string
  description = "Linux Distribution"
  default     = "ubuntu"
}

variable "distro_version" {
  type        = string
  description = "Linux Distribution Version"
  default     = "20-04"
}

variable "server_region" {
  type        = string
  description = "Digital Ocean Datacenter Region"
  default     = "nyc1"
}

variable "k3s_server_name" {
  type        = string
  description = "Name for the K3s Server. Only valid hostname characters are allowed. (a-z, A-Z, 0-9, . and -)"
}

variable "server_vcpus" {
  type        = number
  description = "The number of CPUs allocated to Droplets of this size."
  default     = 4
}

variable "server_memory" {
  type        = number
  description = "The amount of RAM allocated to Droplets created of this size. The value is measured in megabytes."
  default     = 8192
}

variable "server_monthly_cost" {
  type        = number
  description = "The monthly cost of Droplets created in this size if they are kept for an entire month. The value is measured in US dollars."
  default     = 48
}

variable "ssh_key_name" {
  type        = string
  description = "The name of the SSH key you uploaded to Digital Ocean.  Will be used to access the server."
}

variable "private_ssh_key_path" {
  type        = string
  description = "Path to the private key used to access the server. Required to download the k3s.yaml configuration"
}
