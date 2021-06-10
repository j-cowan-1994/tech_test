module "tech_test" {
    source          = "./modules/ec2/"
    ami             = "ami-0b22fcaf3564fb0c9"
    instance_type   = "t2.micro"
    public_ip       = true
    key_name        = "admin_key"

    security_groups = [
        aws_security_group.security_group.id,
    ]

    #tags
    name            = "test_instance"

}

resource "aws_security_group" "security_group" {
  name        = "security_group"
  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    cidr_blocks = ["90.216.150.192/26"]
  }
  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    cidr_blocks = ["90.216.134.192/26"]
  }

  ingress {
    from_port   = 19999
    to_port     = 19999
    protocol    = "tcp"
    cidr_blocks = ["90.216.150.192/26"]
  }
  ingress {
    from_port   = 19999
    to_port     = 19999
    protocol    = "tcp"
    cidr_blocks = ["90.216.134.192/26"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["90.216.150.192/26"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["90.216.134.192/26"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["172.31.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
