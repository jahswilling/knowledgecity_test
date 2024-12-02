resource "aws_ecr_repository" "knowledgecity" {
    name                 = "knowledgecity"
    image_scanning_configuration {
        scan_on_push = true
    }
    image_tag_mutability = "MUTABLE"
}

output "ecr_repository_url" {
    value = aws_ecr_repository.knowledgecity.repository_url
}


resource "aws_ecr_repository" "knowledgecity_php" {
    name = "knowledgecity_php"
    image_scanning_configuration {
        scan_on_push = true
    }
    image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "knowledgecity_python" {
    name = "knowledgecity_python"
    image_scanning_configuration {
        scan_on_push = true
    }
    image_tag_mutability = "MUTABLE"
}

output "php_ecr_repository_url" {
    value = aws_ecr_repository.knowledgecity_php.repository_url
}

output "python_ecr_repository_url" {
    value = aws_ecr_repository.knowledgecity_python.repository_url
}
