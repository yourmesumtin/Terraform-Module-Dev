#........networking/variables.tf-------

variable "max_subnets" {
  type = number
}
variable "vpc_cidr" {
  type = string
}
variable "public_sn_count" {
  type = number
}
variable "public_cidrs" {
  type = list(any)
}
variable "private_sn_count" {
  type = number
}
variable "private_cidrs" {
  type = list(any)
}
variable "access_ip" {
  type = string
}
variable "security_groups" {}

variable "db_subnet_group" {
  type = bool

}