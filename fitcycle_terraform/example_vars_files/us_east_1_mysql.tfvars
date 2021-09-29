# This file will deploy resources in AWS us-east-1 region
# It will use the MySql EC2 Instance to deploy 
# Set the AWS Access and Secret Key

# Enable this only when using Access Key and Secret Key
#option_1_aws_access_key = ""    
#option_2_aws_secret_key = ""

# Use these variable when use shared credential file - i,e: with aws credentials file . Refer to README for steps
# shared_credentials_file_location = "/Users/joe/.aws/credentials"
# The profile name is the value you provided in this command - 'aws configure --profile demo'
# profile = "demo" 

region = "us-east-1"

option_3_aws_vpc_name = "fitcycleDemo"
option_4_aws_vpc_cidr = "10.0.0.0/16"

# Add public SSH key here for mgmt instance in option 6
option_5_aws_admin_ssh_key_name = "adminKey"
option_6_aws_admin_public_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCpn2SYC3eKiMpTgHwPbh50cXk3EOfsFnMCAfH/KAROfzTmBbZiUu/s5fGuOBJtStZ02GAq+W2swomdve6i2knxykBEG/SD7EuwcoITp2od1T2HC4CLH9wO/wUkuZCqUDWBQeRqOBWSLraEcmaJesoRtoBPaGH9h+PZX5Qx3DavXfVEC6hg86jZrrnKA+X/IkHzLMqeubbaAZMmp8NiZX9AQiVzPQ8BsPV4/3mcNBCV7nPSIJbJflJ5XDX0runJRjyxRbk/EfDHws+nNx/GE4VfSc0XQ0Y2CVdLqui1qnrfD50diSXXZUwBay4YzzVf4CHfiUmURBvMfljPA70X6RYKgyf6VDspHhfp/w4bOCpImCnsv2Ksxah7JZ3kK/u3S7yreRA5gdpSf2gKrovIbgimtyQw6fkrXD0c1NmMz78IZpuWf+tFnTJ6F8QJfKwRmLiilhme/dtkyV6gonhk2a1Jm/IVU4TVYfd+dwa9f1kUYYefx/aNWROAIGwkz0itA+KmA0g48Va47qpbZOEWZCz+AHAW+yKIAigSl10qjo1VZ9gVJHCIS3kxLNdwyk59MUTC8Oqo22XZwBksJc7ac2KOdxtecXiv+r/9MliSBC3A7B3u6J+e7GWGxkotfKj8fUzkOOlR+cm5QfV4Xlo9CAZ2hGPvphd1w9rHRDmXDgD8VQ== admin@vmw.com"

# Add public SSH key here for other instances in option 8 
option_7_aws_dev_ssh_key_name = "devKey"
option_8_aws_dev_public_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHnlzylsmBLfxLjNwWD9iTpGVh6fMOnroLgFL5WRKgTht1oNn4zZVMrO35Ljg4B8uFiDYb/dttoDOJDnWc1/OtCEBPpI13k4c4T6DpEpUqVzkBLJte2zt9B7KxK/YdNXTwGKdzJv5wAxBzGsVRTjqttNtICwrvehxKbVwqPSmsPq7kFnmWAOH8kWO5AQ0L3Se8xkWOb+heSdx/FFSilsFLecKfYxqi91s25hwcPmUrFuGvWT49jtU+o8x//CDpzqPwij79kXX5ou/INfzIqsRcWML97GHHu3oeUn77HY0Zhb4/DARECRickUPnvmZSD3SJ05pPJDVimO27Xo8VGTBFzrTA+f74tL4h0piZftTLc8R4Hbc+KSy5ZvITASa0W7IqHVGlImelIr66DzxFGY9XN1JO+9c45B+FXh9PJaGp/98cXn3CZFqV94PJngFarNR7JnDRktWSj62JLDrabXXc0MBlaUVWFWJkvPTFCJ74JT5mPO3m19kx5zBbZ0VOo1RLpHn+8lVzRA78Fk8eImH5/7lUDQwr5HbXFBATvtqfGD3/DDCiyUycI29JFFz4j7ChTQ4CAkjnHgbsnkVmnvNNKt6+sTAiGCQXGNE5tqCm8aKtdA3XuxM7jSgkixxrdv8+LPoXoGPkee2yaVLBz+IH4Fg6Sx6Rf+h3wGVoGGZsIQ== dev@vmw.com"

# Deploy MySql EC2 instance.
option_9_use_rds_database = 0
option_10_aws_rds_identifier = 0
option_11_multi_az_rds = 0

product = "fitcycle"
team = "dev-team"
owner = "teamlead"
environment = "staging"
organization = "acmefitness"
costcenter = "acmefitness-eng"
