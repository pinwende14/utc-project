resource "aws_security_group" "database-sg" {
  name   = "database-sg"
  vpc_id = module.utc-vpc.vpc_id


  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app-server-sg.id]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "database-sg"
    env  = "dev"
    team = "config management"
  }
}
