#! /bin/bash

echo "Entered bootstrap.sh"
echo "Installing Post Vagrant-Postprocessor software.."

sudo apt-get install -y git
#sudo apt-get install dos2unix

#sudo apt-get install -y software-properties-common
#sudo apt-get update
#sudo apt-get install -y extlinux
#sudo apt-get install -y ntfs-3g
#sudo apt-get install -y pmount

#sudo dpkg --ignore-depends=attr,gawk,parted,dosfstools,isolinux,iproute,xorriso,ethtool,syslinux -i /vagrant/resources/rear_2.2_amd64.deb
#sudo apt-get -y -f install

echo "Installation of Post Vagrant-Postprocessor software complete."
