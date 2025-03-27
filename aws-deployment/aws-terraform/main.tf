module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.0.0"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.27"
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  # Use the IAM role explicitly
  iam_role_arn = aws_iam_role.eks_cluster_role.arn
}

####
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
    }]
  })

  tags = {
    Name        = "eks-cluster-role"
    Environment = "production"
  }
}

resource "aws_iam_policy" "eks_cluster_policy" {
  name        = "eks-cluster-policy"
  description = "IAM policy for EKS Cluster"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "ec2:DescribeInstances",
          "ec2:DescribeRegions",
          "eks:DescribeCluster",
          "eks:ListClusters"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_attach" {
  policy_arn = aws_iam_policy.eks_cluster_policy.arn
  role       = aws_iam_role.eks_cluster_role.name
}
