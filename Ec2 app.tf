resource "aws_instance" "app-server" {
  ami                    = "ami-0fa1de1d60de6a97e"
  instance_type          = "t2.micro"
  key_name               = "utc-key"
  vpc_security_group_ids = [aws_security_group.app-server-sg.id]
  subnet_id              = module.utc-vpc.private_subnets[count.index]
  availability_zone      = var.availability_zone[count.index]
  count = 2
  user_data = <<-EOF
  #!/bin/bash

   sudo yum update -y

   sudo yum install -y httpd.x86_64

   sudo systemctl start httpd.service

   sudo systemctl enable httpd.service

   sudo echo “Hello World from $(hostname -f)” > /var/www/html/index.html
     EOF

  tags = {
    Name = "apppserver-1a , appserver-1b-${count.index}"
    env  = "dev"

    team = "config management"

  }

  depends_on = [
    aws_instance.bastion-host
  ]
}
