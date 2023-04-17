resource "aws_security_group" "bastion-host-sg" {
  name        = "bastion-host-sg"
  description = "Allow ip to 22 inbound traffic"
  vpc_id      = module.utc-vpc.vpc_id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "bastion-sg"
    env  = "dev"
    team = "config management"
  }
}
