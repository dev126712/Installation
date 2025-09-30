### Installation of Docker, Terraform, Kubernetes(kubectl & Minikube) and AWS cli for Debian, Ubuntu.

## User Data
``` bash
#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install git -y
git clone https://github.com/dev126712/Installation.git
cd Installation
chmod +x 'Docker&Terrafort.sh'
./'Docker&Terrafort.sh'
```
