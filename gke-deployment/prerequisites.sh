#!/bin/bash

# Update system packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl unzip tar jq

# Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl
echo "kubectl installed:"
kubectl version --client --output=yaml

# Install eksctl
echo "Installing eksctl..."
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
echo "eksctl installed:"
eksctl version

# Install AWS CLI v2
echo "Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip
echo "AWS CLI installed:"
aws --version

# Configure shell completions
echo "Configuring shell completions..."
echo 'source <(kubectl completion bash)' >> ~/.bashrc
echo 'source <(eksctl completion bash)' >> ~/.bashrc
echo 'complete -C /usr/local/bin/aws_completer aws' >> ~/.bashrc
source ~/.bashrc

echo ""
echo "Installation complete!"
echo "Now run 'aws configure' to set up your AWS credentials"
echo "Required tools versions:"
echo "- kubectl: $(kubectl version --client --short 2>/dev/null)"
echo "- eksctl: $(eksctl version)"
echo "- AWS CLI: $(aws --version 2>&1)"