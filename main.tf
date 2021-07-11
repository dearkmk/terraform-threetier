# This file is used to create a three tier architecture. It creates
# 1 web server (Nginx), 2 app servers (Tomcat 8) , 1 db server (RDS) 
# and 1 security group (allow_all)
# Code is written by KMK - 11/07/2021

# Code used to mention the provider details 
provider "aws" {
 region       = "${var.region}"
 access_key   = "${var.accesskey}"
 secret_key   = "${var.secretkey}" 
}

# Code used for provisioning the security group 
resource "aws_security_group" "allow_all" {
  name = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id = "${var.vpcid}"

# Code used to define the inbound traffic
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Code used to define the outbound traffic
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# End of the Security group code


# Code used for provisioning the web server, Nginx
resource "aws_instance" "webserver" {
  ami = "${var.imageid}"
  instance_type = "${var.instancetype}"
  key_name = "${var.key}"
  security_groups = ["${aws_security_group.allow_all.name}"]

# Code used to connect to the EC2 instance
  connection {
    user = "ubuntu"
    host  = "${aws_instance.appserver1.public_ip}"
    private_key = "${file(var.privatekeypath)}"
  }

# Code used to install Nginx server
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt install -y nginx-core --fix-missing",
    ]  
  }
}
# End of the web server code

# Code used for provisioning the app server1, Tomcat 8
resource "aws_instance" "appserver1" {
  ami = "${var.imageid}"
  instance_type = "${var.instancetype}"
  key_name = "${var.key}"
  security_groups = ["${aws_security_group.allow_all.name}"]

# Code used to connect to the EC2 instance
  connection {
    user = "ubuntu"
    host  = "${aws_instance.appserver1.public_ip}"
    private_key = "${file(var.privatekeypath)}"
  }

# Code used to install the app server1, Tomcat8 
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-8-jdk",
      "sudo export JAVA_HOME=~/openjdk11.0.11",
      "sudo export JRE_HOME=~/openjdk11.0.11/jre",
      "sudo apt-get install tomcat8 -y",
    ]  
  }
}
# End of app server1 code

# Code used for provisioning the app server2, Tomcat 8
resource "aws_instance" "appserver2" {
  ami = "${var.imageid}"
  instance_type = "${var.instancetype}"
  key_name = "${var.key}"
  security_groups = ["${aws_security_group.allow_all.name}"]

# Code used to connect to the EC2 instance
  connection {
    user  = "ubuntu"
    host  = "${aws_instance.appserver2.public_ip}"
    private_key = "${file(var.privatekeypath)}"
  }

# Code used to install the app server2, Tomcat8
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-8-jdk",
      "sudo export JAVA_HOME=~/openjdk11.0.11",
      "sudo export JRE_HOME=~/openjdk11.0.11/jre",
      "sudo apt-get install tomcat8 -y",
    ]  
  }
}
# End of app server2 code

# Code used for provisioning the RDS database
resource "aws_db_instance" "dbserver" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
# End of RDS DB server code