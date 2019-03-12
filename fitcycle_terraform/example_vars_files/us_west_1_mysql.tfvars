# This file will deploy resources in AWS us-west-1 region
# It will use the MySql EC2 Instance to deploy 
# Set the AWS Access and Secret Key

#option_1_aws_access_key = ""    
#option_2_aws_secret_key = ""
region = "us-west-1"

images = {
    web="ami-029218bb923933d1a"
    mgmt="ami-048ef73aadc6c3bf6"
    dblb="ami-06eb4b1fd6d3fa7f7"
    db="ami-001af27175ceb5c1d"
    app="ami-0cbde20c9254f27cf"
    api="ami-013c6f058d5323ba3"
}

option_3_aws_vpc_name = "fitcycleDemo"
option_4_aws_vpc_cidr = "10.0.0.0/16"

# Add Public SSH key in option 6 
option_5_aws_ssh_key_name = "myTestKey"
option_6_aws_public_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDfvnnPxVhm9uUIeUOMU/tytgHbYc/qdumcjcz7wvuF5jDvOICw3iCgCx9BoclQ36O2aIqLjTz80ztBpTaLVQJOPCnSIQSgmf9PYxIlPpxYztrJZz921cdv6pAfrvJHM7rdVR4D9QyE81MCorOIfJJ3g31PEPMVNtiXZ6Lq8hZkLNKCadh5tTyCzztS9yWPRwEj4jZ53FW2f4v3CmGursMj4Sczn2XzajxnmnJj9w5q4HrPN+df0JbiF4YDOuGDR9EfopSpCTUYeRQPLfCZ8gYpA3sAaktqv51eXM8DJi4fyqS7IwSJ4cwlm5pIVCqvyUPi8jdWnJ0TUeoV8HTCNFCV demo"

# Deploy MySql EC2 instance.
option_7_use_rds_database = 0
option_8_aws_rds_identifier = 0
option_9_multi_az_rds = 0

product = "fitcycle"
team = "dev-team"
owner = "teamlead"
environment = "staging"
organization = "acmefitness"
costcenter = "acmefitness-eng"