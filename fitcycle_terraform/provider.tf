# Provide AWS credentials

# Use the command 'aws configure --profile <PROFILE NAME HERE>' . It will then prompt you for access key and secret key
# In the vars file provide the shared_credentials_file_location - it is usually located at /Users/<myuser>/.aws/credentials

provider "aws" {
  shared_credentials_file = var.shared_credentials_file_location
  region                  = var.region
  profile                 = var.profile
}

## You can also use it with access key and secret key. This is not recommended as best practice

# provider "aws" {
#   access_key = var.option_1_aws_access_key
#   secret_key = var.option_2_aws_secret_key
#   region                  = var.region
# }


# This allows terraform to backup the *.tfstate file to AWS s3 bucket. Uncomment or Remove the lines to disable remote backup and use local state (Not Recommended)
# terraform {
#   backend "s3" {
#     bucket = "mybucket"
#     key    = "path/to/my/key/some.tfstate"
#     region = "us-east-1"
#   }
# }
# Here it is initialized with empty parameters. Other params can be passed at "terraform init --backend-config="bucket=mybucket" --backend-config="key=path/to/my/key/some.tfstate" --backend-config="region=us-east-1""

#terraform {
#  backend "s3" {
#  }
#}

