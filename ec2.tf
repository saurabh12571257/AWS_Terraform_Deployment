resource "aws_key_pair" "my_key" {
  key_name   = "terra-new-key-ec2"
  public_key = file("terraform-key.pub")
}

resource "aws_default_vpc" default{

}


resource "aws_security_group" "allow_tls" {
  name        = "automate-sg-new"
  description = "permission to access the ec2."
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access from anywhere."
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP access from anywhere."
  }

  ingress {
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow to access App from anywhere."
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic."
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "my_instance" {

    for_each = tomap(
        {
            instance1 = "t2.micro",
            instance2 = "t2.medium"

        }
    )
    #count = var.count_of_instance
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.allow_tls.name]
    instance_type = each.value
    ami = var.aws_ami_id

    user_data = file("install_nginx.sh")

    root_block_device {
        volume_size = var.env == "prod" ? 20 : var.root_store_size
        volume_type = "gp3"
    }

    tags = {
        Name = each.key
    }
}

