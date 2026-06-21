############################################
# Part 1: S3 Backend Configuration
############################################

terraform {
  backend "s3" {
    bucket         = "digilians-tfstate"
    key            = "assignment/alb-asg/terraform.tfstate"
    region         = "us-west-1"
    use_lockfile = true  
    encrypt        = true
  }
}

