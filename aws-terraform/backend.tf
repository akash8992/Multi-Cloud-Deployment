terraform {
  backend "s3" {
    bucket = "interview-assignment-terraform" 
    key    = "EKS/terraform.tfstate"
    region = "ap-south-1"
  }
}
