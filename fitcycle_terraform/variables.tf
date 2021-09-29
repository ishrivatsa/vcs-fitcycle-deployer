# Variables for accepting Access Key and Secret key for AWS
# Default region is set to us-east-1

# variable "option_1_aws_access_key" {
# }

# variable "option_2_aws_secret_key" {
# }

variable "shared_credentials_file_location" {
}

variable "profile" {
}

variable "region" {
  default = "us-east-1"
}

variable "images" {
  type = map(string)
  default = {
    web  = "ami-0424ce05e6eac4d44"
    mgmt = "ami-09b7afbfbed29099c"
    dblb = "ami-0c287d8bb736b0dc4"
    db   = "ami-03442710b971503b5"
    app  = "ami-0c5a97dcec802ce81"
    api  = "ami-04aba6a14439a24d2"
  }
}

variable "option_3_aws_vpc_name" {
}

variable "option_4_aws_vpc_cidr" {
}

variable "option_5_aws_admin_ssh_key_name" {
}

variable "option_6_aws_admin_public_ssh_key" {
}

variable "option_7_aws_dev_ssh_key_name" {
}

variable "option_8_aws_dev_public_ssh_key" {
}

variable "option_9_use_rds_database" {
}

variable "option_10_aws_rds_identifier" {
}

variable "option_11_multi_az_rds" {
}

variable "product" {
}

variable "team" {
}

variable "owner" {
}

variable "environment" {
}

variable "organization" {
}

variable "costcenter" {
}

