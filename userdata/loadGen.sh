#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# usually we would be forwarded into the shell, with noninteractive we tell it to start the service in "background"
export DEBIAN_FRONTEND=noninteractive

#region install docker

# update existing packages
apt-get update

# install new packages
# -y answer yes to all prompted inputs
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

#-f fail silent, -s no progress meter or error messages, -S in combination with -s makes curl show error msg if it fails, 
# -L if the page moved to a new Location, the curl will be performed again at the new location
# download the pgp key from docker *pipe* add the key to the local keychain
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# very the key by searching the keychain for the last 8 digits of the key
apt-key fingerprint 0EBFCD88

#add-apt-repository is used to get applications which are not available from the default Ubuntu repositories, additionally we mark a version to download in the command
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
# update existing packages
apt-get update
# (again -y to answer with yes), we install the latest docker engine as well as containered.io, which is a container runtime
apt-get install -y docker-ce docker-ce-cli containerd.io

# endregion

# region Launch containers

# Run the load generator
# -d tells docker to run the container silent
# restart:always tells the container to restart after a crash
# -p 8080:8080 maps the vms port 8080 to the containers port 8080
docker run -d \
  --restart=always \
  -p 8080:8080 \
  janoszen/http-load-generator:1.0.1

docker run -d \
  --net="host" \
  --pid="host" \
  -v "/:/host:ro,rslave" \
  quay.io/prometheus/node-exporter \
  --path.rootfs=/host