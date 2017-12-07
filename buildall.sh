#! /bin/bash

TEMPLATE_IMAGE="debian-8.9.0-amd64-DVD-1.iso"
REAR_PACKAGE="rear_2.2_amd64.deb"

if ! [ "$(ls -A resources/$TEMPLATE_IMAGE)" ] ; then
    echo "The resources directory does not contain the appropriate image: $TEMPLATE_IMAGE."
    echo "Make sure to download the $TEMPLATE_IMAGE feeder image before re-running this script."
elif ! [ "$(ls -A target/resources/$REAR_PACKAGE)" ] ; then
    echo "The target/resources directory does not contain the REAR debian: $REAR_PACKAGE."
    echo "Make sure to download the $REAR_PACKAGE debian before re-running this script."
	echo
	echo "http://download.opensuse.org/repositories/Archiving:/Backup:/Rear/Debian_8.0/amd64/"
else
    echo "Destroying existing vagrant boxes.."
    vagrant global-status --prune
    vagrant destroy -f

    vagrant box remove vbox
    vagrant box remove vmware

    rm -r target/*.box &> /dev/null
    rm -r target/output-vmware-1 &> /dev/null

    echo "Building with Packer.."
    cd target
    packer build -force ../mineoffice.json

    echo "Adding Vagrant Box.."
    vagrant box add vbox packer_virtualbox-1_virtualbox.box -f

    echo "Provisioning Vagrant Box.."
    vagrant up --provision

    cd ..

fi
