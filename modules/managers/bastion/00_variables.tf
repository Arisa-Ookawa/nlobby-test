/**
# Variables for COMMON
*/
variable "common" {
  type = object({
    project     = string
    environment = string
  })

  default = {
    project     = ""
    environment = ""
  }
}

variable "sfx" {
  type    = string
  default = "01"
}

/**
# Variables for EC2
*/
variable "vpc_id" {
  type    = string
  default = ""
}

variable "bastion_subnet_id" {
  type        = string
  default     = ""
  description = "Subnet where the bastion server is located"
}

variable "associate_public_ip_address" {
  type    = string
  default = true
}

variable "ami" {
  type        = string
  default     = "ami-05a03e6058638183d" # MEMO: 要確認
  description = "AMI ID to launch"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "The type of instance to launch"
}

variable "root_block_device" {
  type = object({
    volume_type           = string
    volume_size           = number
    delete_on_termination = bool
  })

  default = {
    volume_type           = "gp3"
    volume_size           = 8
    delete_on_termination = false
  }

  description = "Setting the root volume associated with the instance"
}