variable "instance_type" {
  default     = "t2.micro"
  type        = string
}

variable "ami_id" {
    default = "ami-0f5fcdfbd140e4ab7"
    type = string
}

variable "volume_size" {
    default = 8
    type = number
}

variable "env" {
  default = prod
  type = string
}