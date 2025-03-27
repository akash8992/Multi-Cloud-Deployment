variable "project_id" {
  description = "multi-cloud-deploy"
  type        = string
}

variable "region" {
  description = "multi-cloud-deploy"
  type        = string
  default     = "us-central1"
}

variable "network_name" {
  description = "VPC network name"
  type        = string
  default     = "gke-vpc"
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "gke-subnet"
}

variable "gke_cluster_name" {
  description = "multi-cloud-deploy-cluster"
  type        = string
  default     = "gke-cluster"
}

variable "node_count" {
  description = "Number of nodes in the GKE cluster"
  type        = number
  default     = 2
}
