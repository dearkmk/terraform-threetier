# Code to define the variables required for provisioning threetier 
# architecture

variable "region" {
  default  = "us-west-2"
}

# The following 2 variables are input parameters
variable "accesskey" {
  type  = string
}

variable "secretkey" {
  type  = string
}

variable "imageid" {
  default  = "ami-090717c950a5c34d3"
  description = "ubuntu 18 image"
}

variable "key" {
  default = "terraform"
#  default = "tfkeypair" 
}

# The following variable is input parameter
variable "privatekeypath" {
  type = string
}

variable "instancetype" {
  default = "t2.micro"
}

variable "vpcid" {
  default = "vpc-7deecb05"
}