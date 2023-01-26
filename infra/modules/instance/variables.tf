variable "instance_name" {
  type = string
  description = "Name so that instance can be easily recognized in AWS web console."
}

variable "ssh_key" {
  type = string
  description = "Ssh key of the developer that is creating EC2 instance so that he has access inside for provisioning."
}

variable "ecr_url" {
  type = string
  description = "E.g. 838484.dkr.ecr.xxxx-xx-1.amazonaws.com so without image name at the end and without tag"
}

variable "instance_unique_variable" {
  type = string
  description = "Imaginary environment variable. In this case it is used in PHP app to simply display it."
}
