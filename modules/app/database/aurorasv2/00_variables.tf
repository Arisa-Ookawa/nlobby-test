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