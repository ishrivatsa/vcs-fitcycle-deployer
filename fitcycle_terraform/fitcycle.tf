# This terraform template will deploy fitcycle in HA configuration
# It will provision the following resource

data "aws_availability_zones" "available" {}

resource "aws_vpc" "vcs_vpc" {
  cidr_block           = "${var.aws_vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name          = "${var.aws_vpc_name}"
    Product       = "${var.product}"
    Team          = "${var.team}"
    Owner         = "${var.owner}"
    Environment   = "${var.environment}"
    Organization  = "${var.organization}"
    "Cost Center" = "${var.costcenter}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id          = "${aws_vpc.vcs_vpc.id}"
  cidr_block      = "${cidrsubnet(aws_vpc.vcs_vpc.cidr_block, 8, 2)}"
  tags = {
    Name          = "subnet-${var.aws_vpc_name}"
    Product       = "${var.product}"
    Team          = "${var.team}"
    Owner         = "${var.owner}"
    Environment   = "${var.environment}"
    Organization  = "${var.organization}"
    "Cost Center" = "${var.costcenter}"
   }

}


resource "aws_subnet" "rds_subnet_1" {
  count      = "${var.use_rds_database}"
  vpc_id     = "${aws_vpc.vcs_vpc.id}"
  cidr_block = "${cidrsubnet(aws_vpc.vcs_vpc.cidr_block, 8, 3)}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  tags = {  
    Name          = "subnet-rds-1-${var.aws_vpc_name}"
    Product       = "${var.product}"
    Team          = "${var.team}"
    Owner         = "${var.owner}"
    Environment   = "${var.environment}"
    Organization  = "${var.organization}"
    "Cost Center" = "${var.costcenter}"
   }

}


resource "aws_subnet" "rds_subnet_2" {
  count      = "${var.use_rds_database}"
  vpc_id     = "${aws_vpc.vcs_vpc.id}"
  cidr_block = "${cidrsubnet(aws_vpc.vcs_vpc.cidr_block, 8, 4)}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  tags = {
    Name          = "subnet-rds-2-${var.aws_vpc_name}"
    Product       = "${var.product}"
    Team          = "${var.team}"
    Owner         = "${var.owner}"
    Environment   = "${var.environment}"
    Organization  = "${var.organization}"
    "Cost Center" = "${var.costcenter}"
   }

}


resource "aws_db_subnet_group" "rds_subnet_group" {
  count      = "${var.use_rds_database}"
  name       = "rds_subnet_group"
  subnet_ids = ["${aws_subnet.rds_subnet_1.id}", "${aws_subnet.rds_subnet_2.id}"]

  tags {

    Name          = "subnet_group-rds-${var.aws_vpc_name}"
    Product       = "${var.product}"
    Team          = "${var.team}"
    Owner         = "${var.owner}"
    Environment   = "${var.environment}"
    Organization  = "${var.organization}"
    "Cost Center" = "${var.costcenter}"
  }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vcs_vpc.id}"
    tags = {
       Name          = "IG-${var.aws_vpc_name}"
       Product       = "${var.product}"
       Team          = "${var.team}"
       Owner         = "${var.owner}"
       Environment   = "${var.environment}"
       Organization  = "${var.organization}"
       "Cost Center" = "${var.costcenter}"
    
    }

}


resource "aws_route_table" "rtb" {
    vpc_id = "${aws_vpc.vcs_vpc.id}"
    tags = {
      Name          = "RTB-${var.aws_vpc_name}"
      Product       = "${var.product}"
      Team          = "${var.team}"
      Owner         = "${var.owner}"
      Environment   = "${var.environment}"
      Organization  = "${var.organization}"
      "Cost Center" = "${var.costcenter}"
    }

}


resource "aws_route" "internet_access" {
    route_table_id         = "${aws_route_table.rtb.id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = "${aws_internet_gateway.igw.id}"
}


resource "aws_route_table_association" "public_subnet_assoc" {
     subnet_id      = "${aws_subnet.public_subnet.id}"
     route_table_id = "${aws_route_table.rtb.id}"
}

resource "aws_key_pair" "ssh_key" {
      key_name   = "${var.aws_ssh_key_name}"
      public_key = "${var.aws_public_ssh_key}"
}

resource "aws_security_group" "mgmt_sg" {
     name   = "mgmt_${var.aws_vpc_name}"
     vpc_id = "${aws_vpc.vcs_vpc.id}"
     ingress {
        from_port = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
     }

     ingress {
        from_port   = 24224
        to_port     = 24224
        protocol    = "tcp"
        cidr_blocks = ["${var.aws_vpc_cidr}"]
    }

     ingress {
        from_port   = 2878
        to_port     = 2878
        protocol    = "tcp"
        cidr_blocks = ["${var.aws_vpc_cidr}"]
    }
      
     egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "web_sg" {
     name   = "web_${var.aws_vpc_name}"
     vpc_id = "${aws_vpc.vcs_vpc.id}"
     ingress {
        from_port = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${var.aws_vpc_cidr}"]
     }

     ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

     ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

     egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "app_sg" {
     name   = "app_${var.aws_vpc_name}"
     vpc_id = "${aws_vpc.vcs_vpc.id}"
     ingress {
        from_port = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${var.aws_vpc_cidr}"]
     }

     ingress {
        from_port   = 8000
        to_port     = 8000
        protocol    = "tcp"
        cidr_blocks = ["${var.aws_vpc_cidr}"]
    }

     egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "api_sg" {
     name   = "api_${var.aws_vpc_name}"
     vpc_id = "${aws_vpc.vcs_vpc.id}"
     ingress {
        from_port = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${var.aws_vpc_cidr}"]
     }

     ingress {
        from_port   = 5000
        to_port     = 5000
        protocol    = "tcp"
        cidr_blocks = ["${var.aws_vpc_cidr}"]
    }

     egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


resource "aws_security_group" "db_sg" {
     name   = "db_${var.aws_vpc_name}"
     vpc_id = "${aws_vpc.vcs_vpc.id}"
     ingress {
        from_port = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${var.aws_vpc_cidr}"]
     }

     ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["${var.aws_vpc_cidr}"]
    }

     egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


resource "aws_db_instance" "fitcycle_rds_db" {
  count                  = "${var.use_rds_database}"
  identifier             = "rds-fitcycle"
  depends_on             = ["aws_security_group.db_sg"]
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7.23"
  instance_class         = "db.t2.micro"
  name                   = "prospect"
  username               = "db_app_user"
  password               = "VMware1!"
  multi_az               = "${var.multi_az_rds}"
  vpc_security_group_ids = ["${aws_security_group.db_sg.id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.rds_subnet_group.id}"
  skip_final_snapshot    = true
  tags {
         App          = "${var.aws_vpc_name}"
         Name         = "rds-db-${var.aws_vpc_name}"
         Tier         = "DB"
         Product      = "${var.product}"
         Team         = "${var.team}"
         Owner        = "${var.owner}"
         Environment  = "${var.environment}"
         Organization = "${var.organization}"
        "Cost Center" = "${var.costcenter}"
     }
}



resource "aws_instance" "db1" {
     count                  = "${1 - var.use_rds_database}"
     ami                    = "${var.images["db"]}"
     instance_type          = "t2.micro"
     subnet_id              = "${aws_subnet.public_subnet.id}"
     vpc_security_group_ids = ["${aws_security_group.db_sg.id}"]
     key_name               = "${aws_key_pair.ssh_key.id}"
     tags {
         App          = "${var.aws_vpc_name}"
         Name         = "db1-${var.aws_vpc_name}"
         Tier         = "DB"  
         Product      = "${var.product}"
         Team         = "${var.team}"
         Owner        = "${var.owner}"
         Environment  = "${var.environment}"
         Organization = "${var.organization}"
        "Cost Center" = "${var.costcenter}"
     }
}

resource "aws_instance" "db2" {
     count                  = "${1 - var.use_rds_database}"
     ami                    = "${var.images["db"]}"
     instance_type          = "t2.micro"
     subnet_id              = "${aws_subnet.public_subnet.id}"
     vpc_security_group_ids = ["${aws_security_group.db_sg.id}"]
     key_name               = "${aws_key_pair.ssh_key.id}"
     tags {
         App          = "${var.aws_vpc_name}"
         Name         = "db2-${var.aws_vpc_name}"
         Tier         = "DB"
         Product      = "${var.product}"
         Team         = "${var.team}"
         Owner        = "${var.owner}"
         Environment  = "${var.environment}"
         Organization = "${var.organization}"
        "Cost Center" = "${var.costcenter}"
     }
}


resource "aws_instance" "dblb" {
     count                  = "${1 - var.use_rds_database}"
     ami                    = "${var.images["dblb"]}"
     instance_type          = "t2.micro"
     subnet_id              = "${aws_subnet.public_subnet.id}"
     vpc_security_group_ids = ["${aws_security_group.db_sg.id}"]
     key_name               = "${aws_key_pair.ssh_key.id}"
     tags {
         App          = "${var.aws_vpc_name}"
         Name         = "dblb-${var.aws_vpc_name}"
         Tier         = "DBLB"
         Product      = "${var.product}"
         Team         = "${var.team}"
         Owner        = "${var.owner}"
         Environment  = "${var.environment}"
         Organization = "${var.organization}"
        "Cost Center" = "${var.costcenter}"

     }
}

resource "aws_instance" "app1" {
     ami                    = "${var.images["app"]}"
     instance_type          = "t2.micro"
     subnet_id              = "${aws_subnet.public_subnet.id}"
     vpc_security_group_ids = ["${aws_security_group.app_sg.id}"]
     key_name               = "${aws_key_pair.ssh_key.id}"
     tags {
         App          = "${var.aws_vpc_name}"
         Name         = "app1-${var.aws_vpc_name}"
         Tier         = "APP"
         Product      = "${var.product}"
         Team         = "${var.team}"
         Owner        = "${var.owner}"
         Environment  = "${var.environment}"
         Organization = "${var.organization}"
        "Cost Center" = "${var.costcenter}"
     }
}


resource "aws_instance" "app2" {
     ami                    = "${var.images["app"]}"
     instance_type          = "t2.micro"
     subnet_id              = "${aws_subnet.public_subnet.id}"
     vpc_security_group_ids = ["${aws_security_group.app_sg.id}"]
     key_name               = "${aws_key_pair.ssh_key.id}"
     tags {
         App          = "${var.aws_vpc_name}"
         Name         = "app2-${var.aws_vpc_name}"
         Tier         = "APP"
         Product      = "${var.product}"
         Team         = "${var.team}"
         Owner        = "${var.owner}"
         Environment  = "${var.environment}"
         Organization = "${var.organization}"
        "Cost Center" = "${var.costcenter}"
     }
}


resource "aws_instance" "web1" {
     ami                         = "${var.images["web"]}"
     instance_type               = "t2.micro"
     subnet_id                   = "${aws_subnet.public_subnet.id}"
     vpc_security_group_ids      = ["${aws_security_group.web_sg.id}"]
     key_name                    = "${aws_key_pair.ssh_key.id}"
     associate_public_ip_address = true
     tags {
          App          = "${var.aws_vpc_name}"
          Name         = "web1-${var.aws_vpc_name}"
          Tier         = "WEB"
          Product      = "${var.product}"
          Team         = "${var.team}"
          Owner        = "${var.owner}"
          Environment  = "${var.environment}"
          Organization = "${var.organization}"
         "Cost Center" = "${var.costcenter}"
     }
}


resource "aws_instance" "web2" {
     ami                         = "${var.images["web"]}"
     instance_type               = "t2.micro"
     subnet_id                   = "${aws_subnet.public_subnet.id}"
     vpc_security_group_ids      = ["${aws_security_group.web_sg.id}"]
     key_name                    = "${aws_key_pair.ssh_key.id}"
     associate_public_ip_address = true
     tags {
          App           = "${var.aws_vpc_name}"
          Name          = "web2-${var.aws_vpc_name}"
          Tier          = "WEB"
          Product       = "${var.product}"
          Team          = "${var.team}"
          Owner         = "${var.owner}"
          Environment   = "${var.environment}"
          Organization  = "${var.organization}"
          "Cost Center" = "${var.costcenter}"
     }
}


resource "aws_instance" "api1" {
     ami                    = "${var.images["api"]}"
     instance_type          = "t2.micro"
     subnet_id              = "${aws_subnet.public_subnet.id}"
     vpc_security_group_ids = ["${aws_security_group.api_sg.id}"]
     key_name               = "${aws_key_pair.ssh_key.id}"
     tags {
          App           = "${var.aws_vpc_name}"
          Name          = "api1-${var.aws_vpc_name}"
          Tier          = "API"
          Product       = "${var.product}"
          Team          = "${var.team}"
          Owner         = "${var.owner}"
          Environment   = "${var.environment}"
          Organization  = "${var.organization}"
          "Cost Center" = "${var.costcenter}"



     }
}

resource "aws_instance" "api2" {
     ami                    = "${var.images["api"]}"
     instance_type          = "t2.micro"
     subnet_id              = "${aws_subnet.public_subnet.id}"
     vpc_security_group_ids = ["${aws_security_group.api_sg.id}"]
     key_name               = "${aws_key_pair.ssh_key.id}"
     tags {
          App           = "${var.aws_vpc_name}"
          Name          = "api2-${var.aws_vpc_name}"
          Tier          = "API"
          Product       = "${var.product}"
          Team          = "${var.team}"
          Owner         = "${var.owner}"
          Environment   = "${var.environment}"
          Organization  = "${var.organization}"
          "Cost Center" = "${var.costcenter}"
     }
}


resource "aws_instance" "mgmt" {
     ami                         = "${var.images["mgmt"]}"
     instance_type               = "t2.medium"
     subnet_id                   = "${aws_subnet.public_subnet.id}"
     vpc_security_group_ids      = ["${aws_security_group.mgmt_sg.id}"]
     key_name                    = "${aws_key_pair.ssh_key.id}"
     associate_public_ip_address = true
     tags {
          App           = "${var.aws_vpc_name}"
          Name          = "mgmt-${var.aws_vpc_name}"
          Tier          = "MGMT"
          Product       = "${var.product}"
          Team          = "${var.team}"
          Owner         = "${var.owner}"
          Environment   = "${var.environment}"
          Organization  = "${var.organization}"
          "Cost Center" = "${var.costcenter}"     
     }
}

output "vpc_id" {
 
 value = "${aws_vpc.vcs_vpc.id}"

}

output "mgmt_public_ip" {
  
 value = "${aws_instance.mgmt.public_ip}" 

}

output "web1_public_ip" {

 value = "${aws_instance.web1.public_ip}"

}

output "web2_public_ip" {

 value = "${aws_instance.web2.public_ip}"

}
