/** 
# Variables for COMMON
*/
variable "common" {
  type = object({
    project     = string
    environment = string
  })

  default = {
    project     = "nlobby"
    environment = ""
  }
}

variable "sfx" {
  type    = string
  default = "01"
}

/** 
# Availability zone
*/
variable "az1" {
  type    = string
  default = "ap-northeast-1a"
}

variable "az2" {
  type    = string
  default = "ap-northeast-1c"
}

variable "az3" {
  type    = string
  default = "ap-northeast-1d"
}

/** 
# Variables for VPC
*/
variable "vpc_cidr" {
  type    = string
  default = ""
}

/** 
# Variables for Subnet ( Public )
*/
variable "public_az1_cidr" {
  type    = string
  default = ""
}

variable "public_az2_cidr" {
  type    = string
  default = ""
}

variable "public_az3_cidr" {
  type    = string
  default = ""
}

/** 
# Variables for Subnet ( Private )
*/
variable "private_az1_cidr" {
  type    = string
  default = ""
}

variable "private_az2_cidr" {
  type    = string
  default = ""
}

variable "private_az3_cidr" {
  type    = string
  default = ""
}

/** 
# Variables for NatGateway ( Public )
*/
variable "nat_gateway_az1_public_ip" {
  type    = string
  default = ""
}

variable "nat_gateway_az2_public_ip" {
  type    = string
  default = ""
}

variable "nat_gateway_az3_public_ip" {
  type    = string
  default = ""
}

variable "lattice_resource_configuration" {
  type = object({
    type                                           = string
    protocol                                       = string
    allow_association_to_shareable_service_network = bool
    domain_name                                    = string
    ip_address_type                                = string
  })
}