
# Update apt
sudo apt-get update && sudo apt-get upgrade

# Install base packages
sudo apt-get install build-essential zlib1g-dev \
  libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
  libreadline-dev libffi-dev wget

# Install Python 3.7
curl -O https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz
tar -xf Python-3.7.3.tar.xz
cd Python-3.7.3
./configure --enable-optimizations

make -j 4
sudo make altinstall

# Upgrade pip
pip3.7 install --upgrade --user pip

# Remove /usr/bin/pip3.7 in favor of local bin installed from upgrade
sudo rm /usr/bin/pip3.7
