### Installation of Docker, Terraform, Kubernetes(kubectl & Minikube) and AWS cli for Debian, Ubuntu.

#### If not use for User Data make sur to have git install to clone the repo then execute the script.

#### User Data
#### It update the package, install git to clone the repo then execute the srcipt.
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
