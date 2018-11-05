# Variables for accepting Access Key and Secret key for AWS
# Default region is set to us-east-1
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {
    default = "us-east-1"
}
variable "images" {
  type = "map"
  default = {
    web="ami-0424ce05e6eac4d44"
    mgmt="ami-0d76cd17342ed4df5"
    dblb="ami-0c287d8bb736b0dc4"
    db="ami-03442710b971503b5"
    app="ami-0c5a97dcec802ce81"
    api="ami-04aba6a14439a24d2"
   }
}


variable "aws_vpc_name" {}
variable "aws_vpc_cidr" {}
variable "aws_ssh_key_name" {}
variable "aws_public_ssh_key" {}

variable "product" {}
variable "team" {}
variable "owner" {}
variable "environment" {}
variable "organization" {}
variable "costcenter" {}
