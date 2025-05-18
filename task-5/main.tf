# Security Group
resource "aws_security_group" "webserver" {
  name        = "webserver"
  description = "Allow TLS inbound traffic for webserver"

  ingress{
    description = "HTTPS"
    from_port = 443
    to_port   = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    description = "HTTP"
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    description = "SSH"
    from_port = 22
    to_port   = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "webserver"
  }
}



# Setup Server
resource "aws_instance" "webserver"{
    ami = var.ami
    instance_type = var.instance_type
    availability_zone = var.zone
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.webserver.id]

    root_block_device {
    volume_size = 50      
    volume_type = "gp2"
  }

   tags = {
    Name = "webserver"
   } 
}

#