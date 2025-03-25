module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH"
  vpc_id      = module.vpc.vpc_id

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
}

resource "aws_security_group" "private_sg" {
  name   = "private-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# module "bastion" {
#   source        = "../../modules/bastion"
#   ami           = var.ami
#   instance_type = var.bastion_instance_type
#   subnet_id     = module.vpc.public_subnet_ids[0]
#   sg_id         = aws_security_group.bastion_sg.id
#   key_name      = var.key_name
# }

# module "private_ec2" {
#   source        = "../../modules/ec2"
#   ami           = var.ami
#   instance_type = var.ec2_instance_type
#   subnet_id     = module.vpc.private_subnet_ids[0]
#   sg_id         = aws_security_group.private_sg.id
# }