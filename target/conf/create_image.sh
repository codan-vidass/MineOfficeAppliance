#! /bin/bash

correct_usage=true

if [ "$#" -lt 1 ]; then
	echo "X"
    correct_usage=false
elif [ "$#" -eq 1 ]; then
	if [[ $1 = isorescue ]]; then
		echo "Genearting an iso (rescue only).."
		sudo cp /vagrant/conf/rear_iso_rescue.conf /etc/rear/local.conf
		sudo rear -v mkrescue
	elif [[ $1 = iso ]]; then
		echo "Generating an iso.."
		sudo cp /vagrant/conf/rear_iso.conf /etc/rear/local.conf
		sudo rear -v mkbackup
	else
		correct_usage=false
	fi
elif [ "$#" -eq 2 ]; then
	if [[ $1 = usb ]] || [[ $1 = usbiso ]]; then

		if [[ $1 = usb ]]; then
			echo "Generating a USB installer at $2.."
			sudo cp /vagrant/conf/rear_usb.conf /etc/rear/local.conf
		elif [[ $1 = usbiso ]]; then
			echo "Generating a USB iso & backup at $2.."
			sudo cp /vagrant/conf/rear_usb_iso.conf /etc/rear/local.conf
		fi

		sudo rear format -- -y $2
		sudo rear -v mkbackup

		if [[ $1 = usbiso ]]; then
			echo "Copying the iso to the shared directory.."
			sudo mkdir -p /usb
			sudo mount /dev/disk/by-label/REAR-000 /usb
			sudo cp /usb/debian-jessie/rear-debian-jessie.iso /vagrant/resources/
		fi

	else
		correct_usage=false
	fi
elif [ "$#" -gt 2 ]; then
	correct_usage=false
fi

if [[ $correct_usage = false ]]; then
	echo "This script must be provided with argument iso, isorescue, usb or usbiso."
	echo "If the usb or usbiso arguments are used, the USB device address must also be provided."
	echo "e.g. /vagrant/conf/create_image.sh usb /dev/sdb1"
    echo "Run the command sudo fdisk -l to find the appropriate USB drive."
else
	echo "Process Completed."
fi
