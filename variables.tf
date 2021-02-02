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

variable "subnet_ids" {
  type    = "list"
  default = [""]
}