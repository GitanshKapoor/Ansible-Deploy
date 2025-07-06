variable "region" {
  default = "us-east-1"
}

variable "zone" {
  default = "us-east-1a"
}

variable "user1" {
  default = "ubuntu"
}

variable "ami_ids" {
  type = map(any)
  default = {
    ubuntu : "ami-084568db4383264d4", aml : "ami-03a13a09a711d3871"
  }
}