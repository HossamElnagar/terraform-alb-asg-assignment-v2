############################################
# Part 1: S3 Backend Configuration
############################################

terraform {
  backend "s3" {
    bucket         = "digilians-tfstate"
    key            = "assignment/alb-asg/terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "digilians-tfstate-lock"
    encrypt        = true
  }
}

