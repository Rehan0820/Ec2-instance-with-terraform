
resource "aws_key_pair" "deployer" {
  key_name   = "terra-key-ec2"
  public_key = file("Terra-key-pair.pub")

}

# VPC and security group
resource "aws_default_vpc" "default" {


}


resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = " this will add a TF generated security group"
  vpc_id      = aws_default_vpc.default.id # this is called interpolation

  # inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = " SSH open"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = " HTTP open"
  }
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = " Allow all outbound traffic"
  }


  tags = {
    Name = "automate-sg"
  }



}
# ec2 instance
resource "aws_instance" "my_instance" {
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  instance_type          = "t2.micro"
  ami                    = "ami-0d1b5a8c13042c939"

root_block_device {
  volume_size = 15
  volume_type = "gp3"
}


tags = {
  Name = "automate-ec2"
  Environment = "Development"
}
}
