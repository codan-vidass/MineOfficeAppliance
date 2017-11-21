#! /bin/bash

TEMPLATE_IMAGE="debian-jessie.ova"
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
    
    vagrant destroy -f
    vagrant box remove test_box
    
    rm -r target/*.box &> /dev/null
    cd target
    packer build ../mineoffice.json
    vagrant box add test_box packer_virtualbox-ovf-1_virtualbox.box -f
    cd ..
    
fi
