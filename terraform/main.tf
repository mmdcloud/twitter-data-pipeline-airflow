# AMI Lookup
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

# Airflow EC2 Instance
resource "aws_instance" "airflow_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = "shiv"
  associate_public_ip_address = true
  user_data                   = filebase64("${path.module}/scripts/user_data.sh")
  tags = {
    Name = "kafka-instance"
  }
}

# S3 bucket for storing files
resource "aws_s3_bucket" "stock-market-bucket" {
  force_destroy = true
  bucket       = "theplayer007-stock-market-bucket"
}

