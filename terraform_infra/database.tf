resource "aws_db_instance" "db_knowledgecity" {
    allocated_storage    = 20
    storage_type         = "gp2"
    engine               = "mysql"
    instance_class       = var.db_instance_class
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    username             = "kc_owner"
    password             = var.db_password
    db_name              = "knowledgecity"
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    publicly_accessible  = true

    skip_final_snapshot = true

    tags = {
        Name = "knowledgecity-db-${var.environment}"
    }
}

resource "aws_db_subnet_group" "db_subnet_group" {
    name       = "knowledgecity-db-subnet-group-${var.environment}"
    subnet_ids = module.vpc.public_subnets

    tags = {
        Name = "knowledgecity-db-subnet-group-${var.environment}"
    }
}

resource "aws_security_group" "db_sg" {
    vpc_id = module.vpc.vpc_id
    egress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = 0
        to_port     = 0
        protocol    = "tcp"
    }
    ingress {
        from_port   = 3306  # MySQL default port
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "knowledgecity-db-sg-${var.environment}"
    }
}

