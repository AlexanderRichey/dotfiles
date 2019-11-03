set -ex

# Install essentials
sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add docker gpg key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Verify the key
sudo apt-key fingerprint 0EBFCD88

# Add the docker repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Refresh
sudo apt update

# Install docker
sudo apt install docker-ce docker-compose
