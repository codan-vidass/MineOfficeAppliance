#! /bin/bash

if [ "$#" -ne 1 ]; then
    echo "This script must be provided with argument iso, isorescue, or the USB device address."
    echo "Run the command sudo fdisk -l to find the appropriate USB drive."
elif [[ $1 = isorescue ]]; then
    echo "Genearting an iso (rescue only).."
    sudo cp /vagrant/conf/rear_iso_rescue.conf /etc/rear/local.conf
    sudo rear -v mkrescue
elif [[ $1 = iso ]]; then
    echo "Generating an iso.."
    sudo cp /vagrant/conf/rear_iso.conf /etc/rear/local.conf
    sudo rear -v mkbackup
else
    echo "Generating a USB backup at $1.."
    sudo cp /vagrant/conf/rear_usb.conf /etc/rear/local.conf 
    sudo rear format -- -y $1
    sudo rear -v mkbackup 
fi


