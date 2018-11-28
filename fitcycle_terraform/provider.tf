# Provide AWS Access key and Secret Key

provider "aws" {
  access_key = "${var.option_1_aws_access_key}"
  secret_key = "${var.option_2_aws_secret_key}"
  region     = "${var.region}"
}
