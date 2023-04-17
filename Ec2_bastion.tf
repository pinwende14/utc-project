resource "aws_instance" "bastion-host" {

  ami                         = "ami-0fa1de1d60de6a97e"
  instance_type               = "t2.micro"
  key_name                    = "utc-key"
  vpc_security_group_ids      = [aws_security_group.bastion-host-sg.id]
  subnet_id                   = module.utc-vpc.public_subnets[2]
  associate_public_ip_address = true
  user_data                   = <<-EOF
      
           #!/bin/bash
           sudo yum update -y
           sudo chmod 400 utc-key

          EOF


  tags = {
    Name = "bastion-host"
    env  = "dev"
    Team = "config-management"

  }
}
