#! /bin/bash

TEMPLATE_IMAGE="debian-jessie.ova"

if ! [ "$(ls -A template/$TEMPLATE_IMAGE)" ] ; then
    echo "The template directory does not contain the appropriate image: $TEMPLATE_IMAGE."
    echo "Make sure to download the $TEMPLATE_IMAGE feeder image before re-running this script."
else
    rm -r target/* &> /dev/null
    cd target
    packer build ../mineoffice.json
    cd ..
    vagrant box add debian/jessie64 target/packer_virtualbox-ovf-1_virtualbox.box -f
fi
