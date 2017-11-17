#! /bin/bash

TEMPLATE_IMAGE="debian-jessie.ova"

if ! [ "$(ls -A template/$TEMPLATE_IMAGE)" ] ; then
    echo "The template directory does not contain the appropriate image: $TEMPLATE_IMAGE."
    echo "Make sure to download the $TEMPLATE_IMAGE feeder image before re-running this script."
else
    
    vagrant destroy -f
    vagrant box remove test_box
    
    rm -r target/*.box &> /dev/null
    cd target
    packer build ../mineoffice.json
    vagrant box add test_box packer_virtualbox-ovf-1_virtualbox.box -f
    cd ..
    
fi
