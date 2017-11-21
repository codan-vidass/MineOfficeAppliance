#! /bin/bash

echo "Entered bootstrap.sh"
echo "Installing Post Vagrant-Postprocessor software.."

sudo dpkg --ignore-depends=attr,gawk,parted,dosfstools,isolinux,iproute,xorriso,ethtool,syslinux -i /vagrant/resources/rear_2.2_amd64.deb
sudo apt-get -y -f install

echo "Installation of Post Vagrant-Postprocessor software complete."
