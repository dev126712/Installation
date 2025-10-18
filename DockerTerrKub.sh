#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Function to install Docker and related tools
install_docker() {
  echo "--- Installing Docker ---"
  sudo apt install ca-certificates curl gnupg -y
  
  # Add Docker's official GPG key
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  
  # Add the repository to Apt sources
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
  sudo apt-get update
  
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
  echo "--- Docker installed successfully! ---"

  # Give permission to use docker as a non root user

  #sudo chmod 666 /var/run/docker.sock
}

# Function to install Terraform
install_terraform() {
  echo "--- Installing Terraform ---"
  wget -O- https://apt.releases.hashicorp.com/gpg | \
  gpg --dearmor | \
  sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
  
  gpg --no-default-keyring \
  --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
  --fingerprint
  
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  
  sudo apt update
  sudo apt-get install terraform -y
  echo "--- Terraform installed successfully! ---"
}

# Function to install AWS CLI
install_awscli() {
  echo "--- Installing AWS CLI ---"
  sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  sudo unzip awscliv2.zip
  sudo ./aws/install --update
  sudo rm -rf awscliv2.zip ./aws
  echo "--- AWS CLI installed successfully! ---"
}

# Function to install Kubectl and Minikube
install_kubernetes() {
  echo "--- Installing Kubernetes (kubectl) and Minikube ---"
  
  # Install Kubectl via the official Kubernetes repository
  sudo apt-get update
 
  # Find the latest stable version
  sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

  # Make the binary executable
  sudo chmod +x ./kubectl

   # Move the binary into your PATH (e.g., /usr/local/bin)
  sudo mv ./kubectl /usr/local/bin/kubectl
  
  echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  sudo rm /etc/apt/sources.list.d/kubernetes.list
  
  sudo apt-get update
  sudo apt-get install -y kubectl

  
  # Install Minikube
  sudo curl -Lo minikube https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
  sudo install minikube /usr/local/bin/
  
  echo "--- Kubernetes and Minikube installed successfully! ---"
}

# Main script execution
main() {
  echo "--- Starting system update and upgrade ---"
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt install unzip
  echo "--- System update and upgrade completed ---"
  
  install_docker
  install_terraform
  install_awscli
  install_kubernetes
  
  echo "--- All installations completed successfully! ---"
}

# Run the main function
main "$@"
