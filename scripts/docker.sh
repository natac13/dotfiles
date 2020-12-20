printf "${IBlue}Setup Docker...${Color_Off}\\nInstall \`apt\` packages.\\n"

sudo apt-get -y install \
apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

printf "Add Docker’s official GPG key.\\n"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

printf "Verify key fingerprint.\\n"
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

printf "Allow use of Docker without sudo.\\n"
sudo groupadd docker
sudo usermod -aG docker $(USER)
newgrp docker
sudo systemctl enable docker
printf "${IBlue}Finsihed Docker installl.${Color_Off}"
