variable "name" {
  default = ""
}

variable "location" {
  default = ""
}

variable "env" {
  default = ""
}

variable "dnsprefix" {
  default = ""
}

variable "subnet_id" {
  default = ""
}

variable "app_id" {
  default = ""
}

variable "password" {
  default = ""
}

variable "service_cidr" {
  default = "10.0.56.0/22"
}

variable "dns_service_ip" {
  default = "10.0.56.10"
}

variable "docker_bridge_cidr" {
  default = "10.0.60.1/22"
}
