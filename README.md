# vcs-fitcycle-deployer
---------------------
---------------------

## Getting Started 

These instructions will allow you to get a copy of the project and deploy Fitcycle application in AWS. It will
also configure the instances. 

See notes below for troubleshooting.

## Requirements:

Terraform Version: 0.11.0 +

Ensure the correct AMIs are available in the region where the application needs to be deployed. Currently the AMIs
are available in the following region(s)

### Fitcycle AMIs

** us-east-1 (N. Virginia) **

    web="ami-0424ce05e6eac4d44"
    mgmt="ami-0d76cd17342ed4df5"
    dblb="ami-0c287d8bb736b0dc4"
    db="ami-03442710b971503b5"
    app="ami-0c5a97dcec802ce81"
    api="ami-04aba6a14439a24d2"


## Instructions

1. Clone this repository to your local system.

2. It contains 2 directories - `fitcycle_ansible` and `fitcycle_terraform`. Change directory to ` fitcycle_terraform`

3. Create a file name `terraform.tfvars` and populate it with the values listed below. You can also add additional
variable values in this file (See Step 4)

Ensure that aws_vpc_cidr is a /8, /12, /16 network which is in accordance with RFC 1918

```

10.0.0.0 - 10.255.255.255 (10/8 prefix)

172.16.0.0 - 172.31.255.255 (172.16/12 prefix)

192.168.0.0 - 192.168.255.255 (192.168/16 prefix)

```

terraform.tfvars file

```
aws_access_key = " "    
aws_secret_key = " "
region = "us-east-1"

aws_vpc_name = "fitcycleDemo"
aws_vpc_cidr = "10.0.0.0/16"

product = "fitcycle"
team = "dev-team"
owner = "teamlead"
environment = "staging"
organization = "acmefitness"
costcenter = "acmefitness-eng"

```

4.[OPTIONAL] You may also set values for `aws_ssh_key_name` and `aws_public_ssh_key` within the `terraform.tfvars` file as 
shown below.

** Note that doing so can result in an error ` Existing Key Pair`, as AWS doesnot allow creation of ssh keys with
same key name. 

** Alternative to this is to just provide the `aws_public_ssh_key` in the `.tfvars` file and omit the `aws_ssh_key_name`
. By doing so, everytime terraform is run, you can provide a new `ssh key name`



```
aws_access_key = " "
aws_secret_key = " "
region = "us-east-1"

aws_vpc_name = "fitcycleDemo"
aws_vpc_cidr = "10.0.0.0/16"
aws_ssh_key_name = "myTestKey"
aws_public_ssh_key = " PASTE YOUR PUBLIC SSH KEY HERE - file ending with id_rsa.pub"

product = "fitcycle"
team = "dev-team"
owner = "teamlead"
environment = "staging"
organization = "acmefitness"
costcenter = "acmefitness-eng"

```	

[OPTIONAL] If you need to use a different AMI ID(s), use the following `terraform.tfvars` file


```
aws_access_key = " "
aws_secret_key = " "
region = "us-east-1"

images = {

    web="ami-0424ce05e6eac4d44"
    mgmt="ami-0d76cd17342ed4df5"
    dblb="ami-0c287d8bb736b0dc4"
    db="ami-03442710b971503b5"
    app="ami-0c5a97dcec802ce81"
    api="ami-04aba6a14439a24d2"
}

aws_vpc_name = "fitcycleDemo"
aws_vpc_cidr = "10.0.0.0/16"

product = "fitcycle"
team = "dev-team"
owner = "teamlead"
environment = "staging"
organization = "acmefitness"
costcenter = "acmefitness-eng"

```


5. Run `terraform init` to ensure there are no errors. Fix any errors that are reported before proceeding.

6. Run `terraform plan -var-file=terraform.tfvars` to ensure there are no errors. Fix any errors before proceeding. 

7. Run `terraform apply -var-file=terraform.tfvars` to deploy your infrastructure. 

** Alternatively, you may also run `terraform apply -var-file=terraform.tfvars --auto-approve` . This will execute terraform without need for an additional approval step.

8. Once **Terraform** has successfuly completed execution, wait for coupe of minutes and then SSH into the management VM 
or the jumpbox. 

You can login into your AWS console to get the Public IP address for the Management (mgmt) box or you can run the
following command `terraform output`

The output should look like this

```
mgmt_public_ip = 52.90.92.175
web1_public_ip = 35.173.230.151
web2_public_ip = 35.173.211.14

```

9. The mgmt/jumpbox is pre-baked with the ansible templates. Change the directory `fitcycle_ansible`

10. Edit the file export_keys.sh and provide the details for AWS ACCESS KEY and AWS SECRET ACCESS KEY. Then 

Run the command `source export_keys.sh`

11. Run this command
    
     `ansible-playbook configure_fitcycle.yml -e 'db_user=db_app_user db_password=VMware1!' -vvv`

12. Once ansible completes configuring successfully, you can go to a web browser and access the app with any of the 
public IP addresses of the **web** VM.


## Destroying the infrastructure

- Run the command `terraform destroy --var-file=terraform.tfvars --auto-approve`
- If prompted for any input variable, you can enter ANY value. This is currently a bug with terraform.


## Troubleshooting

### Unable to access http://{WEB_PUBLIC_IP} 

- Ensure that public IP addresses were assigned to the instances. 
- Ensure the Security Group allows port 80 from all source IP addresses (0.0.0.0/0)

### Unable to access http://{WEB_PUBLIC_IP}/api/v1.0/signups 

- Repeat step 11 and wait for a few minutes 
- Ensure that the url path is correct

### skipping: no hosts matched

- Repeat step 10 and Ensure the values for `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` are set.
- Run this command `./inventory/ec2.py --refresh-cache`
- Repeat step 11

