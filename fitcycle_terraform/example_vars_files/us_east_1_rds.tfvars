# This file will deploy resources in AWS us-east-1 region
# It will use RDS instance to deploy 
# Set the AWS Access and Secret Key

#option_1_aws_access_key = ""    
#option_2_aws_secret_key = ""
region = "us-east-1"

option_3_aws_vpc_name = "fitcycleDemo"
option_4_aws_vpc_cidr = "10.0.0.0/16"

# Add Public SSH key in option 6 
option_5_aws_admin_ssh_key_name = "adminKey"
option_6_aws_admin_public_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDfvnnPxVhm9uUIeUOMU/tytgHbYc/qdumcjcz7wvuF5jDvOICw3iCgCx9BoclQ36O2aIqLjTz80ztBpTaLVQJOPCnSIQSgmf9PYxIlPpxYztrJZz921cdv6pAfrvJHM7rdVR4D9QyE81MCorOIfJJ3g31PEPMVNtiXZ6Lq8hZkLNKCadh5tTyCzztS9yWPRwEj4jZ53FW2f4v3CmGursMj4Sczn2XzajxnmnJj9w5q4HrPN+df0JbiF4YDOuGDR9EfopSpCTUYeRQPLfCZ8gYpA3sAaktqv51eXM8DJi4fyqS7IwSJ4cwlm5pIVCqvyUPi8jdWnJ0TUeoV8HTCNFCV demo"

option_7_aws_dev_ssh_key_name = "devKey"
option_8_aws_dev_public_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDfvnnPxVhm9uUIeUOMU/tytgHbYc/qdumcjcz7wvuF5jDvOICw3iCgCx9BoclQ36O2aIqLjTz80ztBpTaLVQJOPCnSIQSgmf9PYxIlPpxYztrJZz921cdv6pAfrvJHM7rdVR4D9QyE81MCorOIfJJ3g31PEPMVNtiXZ6Lq8hZkLNKCadh5tTyCzztS9yWPRwEj4jZ53FW2f4v3CmGursMj4Sczn2XzajxnmnJj9w5q4HrPN+df0JbiF4YDOuGDR9EfopSpCTUYeRQPLfCZ8gYpA3sAaktqv51eXM8DJi4fyqS7IwSJ4cwlm5pIVCqvyUPi8jdWnJ0TUeoV8HTCNFCV demo"

# Deploy RDS instance.
# Modify option_9 value to 1, to deploy multi-az RDS
# Note : Multi AZ RDS will take atleast 15 min to deploy
option_9_use_rds_database = 1
option_10_aws_rds_identifier = "fitcycleRds"
option_11_multi_az_rds = 0

product = "fitcycle"
team = "dev-team"
owner = "teamlead"
environment = "staging"
organization = "acmefitness"
costcenter = "acmefitness-eng"
