# The following details are expected to be given to the customer

# Code used to display the IP address of web server
output "webserverip" {
    value = "${aws_instance.webserver.public_ip}"    
}

# Code used to display the IP address of app server1
output "appserver1ip" {
    value = "${aws_instance.appserver1.public_ip}"
}

# Code used to display the IP address of app server2
output "appserver2ip" {
    value = "${aws_instance.appserver2.public_ip}"
}

# Code used to display the end point of the database 
output "dbendpoint" {
    value = "${aws_db_instance.dbserver.endpoint}"
}
