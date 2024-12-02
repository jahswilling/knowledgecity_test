# resource "aws_instance" "bastion" {
#     ami           = "ami-008d05461f83df5b1" # Replace with a valid Amazon Linux AMI ID for your region
#     instance_type = "t3.micro"
#     subnet_id     = element(module.vpc.public_subnets, 0) # Place in the first public subnet
#     key_name      = "knowledgecity" # SSH key to connect to the bastion host
#     associate_public_ip_address = true  
#     # Security group for the bastion host
#     security_groups = [aws_security_group.bastion_sg.id]

#     tags = {
#         Name = "knowledgecity-bastion-${var.environment}"
#     }
# }

# resource "aws_security_group" "bastion_sg" {
#     vpc_id = module.vpc.vpc_id

#     ingress {
#         from_port   = 22
#         to_port     = 22
#         protocol    = "tcp"
#         cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere (restrict for better security)
#     }

#     egress {
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
#     }

#     tags = {
#         Name = "knowledgecity-bastion-sg-${var.environment}"
#     }
# }

# resource "aws_security_group" "private_instance_sg" {
#     vpc_id = module.vpc.vpc_id

#     ingress {
#         from_port   = 22
#         to_port     = 22
#         protocol    = "tcp"
#         cidr_blocks = ["10.0.0.0/16"]
#     }

#     egress {
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
#     }

#     tags = {
#         Name = "knowledgecity-private-instance-sg-${var.environment}"
#     }
# }


# resource "aws_security_group_rule" "allow_ssh_from_bastion" {
#     type                     = "ingress"
#     from_port                = 22
#     to_port                  = 22
#     protocol                 = "tcp"
#     source_security_group_id = aws_security_group.bastion_sg.id
#     security_group_id        = aws_security_group.private_instance_sg.id # Replace with your private instance security group
# }

# output "bastion_public_ip" {
#     value = aws_instance.bastion.public_ip
# }
