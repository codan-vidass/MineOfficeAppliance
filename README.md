# MineOfficeAppliance
Methods for installing the Mine Office Appliance on a new machine

## Core Instructions

1. Launch a new command prompt (as Administrator) and start a git-bash console with the following command:

```bash
C:\PROGRA~1\Git\git-cmd.exe --no-cd --command=usr/bin/bash.exe -l -i
```

(The above is important because not all command-line interfaces will work with the Vagrant box. For example, there are many problems using git-bash directly.)

2. Change into "MineOfficeAppliance" directory.
3. Copy *debian-8.9.0-amd64-netinst.iso* into the *resources* directory. It can be obtained from https://www.debian.org/releases/jessie/debian-installer/
4. Copy *rear_2.2_amd64.deb* into the *target/resources* directory. This is used to install the REAR software for backup/imaging. It can be obtained from http://download.opensuse.org/repositories/Archiving:/Backup:/Rear:/Snapshot/Debian_8.0/amd64/
5. Run from the command prompt `./buildall.sh`
  * This process can take over 5 minutes
  * Sometimes this appears to get stuck, but pressing the ENTER key can trigger the display to update.
6. cd into target directory and run `vagrant up --provision` to launch the built box for the first time. This may take a while (5 minutes).
7. Run `vagrant ssh` (password is vagrant) ( CTRL + C to exit, CTRL + D if it gets stuck, or vagrant halt in another console)
8. For subsequent uses, you can just use `vagrant up` rather than `vagrant up --provision`

## To create REAR image/installation media

In order to see a USB thumbdrive (or equivalent) to write the image/installation to, you will probably need to launch the vagrant box with an associated virtual machine.

To do this with VirtualBox, follow the section *Launching an existing headless vagrant box with VirtualBox* below.

Then on the vagrant box, log in and run the following command assuming the USB is visible (leave out the argument for help): 

`/vagrant/conf/create_image.sh /dev/sdb1`

It will format the USB, and write the ISO and the backup tarball onto that device, then copy the ISO into the /vagrant directory so you can access it from the host.

## Test the installation media using VirtualBox

1. Set up a simple virtual box (Type: Linux, Debian (64-bit)) with all default settings.
2. Right click, settings, storage, add optical drive, choose storage - attach the generated iso (rear-debian-jessie.iso)
3. Make sure that the USB controller is running (Settings, USB, choose USB 3.0) and include a filter for the appropriate device.
4. Launch it, and from the rest-and-recover menu, choose the manual recover option.
5. Follow all of the default prompts (there should be a way to skip this..)
6. Once done, `sudo reboot` the system, and from the rear menu you can choose to boot from the first local disk
7. If you shutdown the VirtualBox and remove the ISO and restart, it should launch simiarly to the system you backed up..

## Launching an existing headless vagrant box with VirtualBox

This is useful for mounting the USB etc..

1. Uncomment the `config.vm.provider "virtualbox" do |vb|` code in the Vagrantfile
2. Type `vagrant suspend` on the host
3. Type `vagrant up` on the host
4. If you're testing a USB, it should show up in the "Devices" menu on VirtualBox, but you might need to unplug it and plug it back in


## Installing vagrant-vbguest plugin on Windows

If you get the following error with the command `vagrant up`:

```bash
Vagrant was unable to mount VirtualBox shared folders. This is usually
because the filesystem "vboxsf" is not available. This filesystem is
made available via the VirtualBox Guest Additions and kernel module.
Please verify that these guest additions are properly installed in the
guest. This is not a bug in Vagrant and is usually caused by a faulty
Vagrant box. For context, the command attempted was:

mount -t vboxsf -o uid=1000,gid=1000 vagrant /vagrant

The error output from the command was:

mount: unknown filesystem type 'vboxsf'
```

You will need to install the *vagrant-vbguest* plugin to set up the shared filesystem. 
Normally this is possible with the command `vagrant plugin install vagrant-vbguest`. 
However, due to codan security, this is likely to fail with an error similar to the following:

```bash
Installing the 'vagrant-vbguest' plugin. This can take a few minutes...
ERROR:  SSL verification error at depth 1: unable to get local issuer certificate (20)
ERROR:  You must add /C=US/ST=California/L=San Jose/O=Zscaler Inc./OU=Zscaler Inc./CN=Zscaler Root CA/emailAddress=support@zscaler.com to your local trusted store
Vagrant failed to load a configured plugin source. This can be caused
by a variety of issues including: transient connectivity issues, proxy
filtering rejecting access to a configured plugin source, or a configured
plugin source not responding correctly. Please review the error message
below to help resolve the issue:

  SSL_connect returned=1 errno=0 state=error: certificate verify failed (https://api.rubygems.org/specs.4.8.gz)

Source: https://rubygems.org/
```

C:\Program Files\Git\usr\ssl\certs\

If this is the case, you will need to add the Zscaler certificate (ZscalerRootCertificate-2048-SHA256.crt) to a system environment variable `SSL_CERT_FILE`.
A good location for storing this file might be: *C:\Program Files\Git\usr\ssl\certs\*

The install command should then work.

## Error updating trust certificates

If you receive the following error (or similar) running the command `update-ca-trust`:

```bash
p11-kit: 'Files/Git/mingw64/bin/trust' is not a valid command. See 'Program --help'
p11-kit: couldn't run trust tool: No error
```

It is likely because of the space in the *Program Files* directory.

This can be avoided by launching the console using the recommended approach at the beginning of the instructions.

## Freezing while SSHing into Vagrant box

Probably due to multiple virtual machines running at the same time:

https://askubuntu.com/questions/716467/vagrant-ssh-terminal-freezes

## Unable to see USB thumbdrive once you've started the recovery process on a new machine

Could be because the VM or original machine you imaged from has fewer USB ports.
As a result, although when you boot the machine it can see the thumbdrive and boot REAR from it, once it has 
loaded the image it can no longer see the device.
Try using a USB port or if possible use VM with more ports as your original source image.

## To get checksum of an ISO for packer .json file

```certutil -hashfile debian-8.9.0-amd64-netinst.iso MD5```

## Using vagrant with VMWare

You'll probably need to install the VMWare plugins, either:

```vagrant plugin install vagrant-vmware-fusion```

or

```vagrant plugin install vagrant-vmware-workstation```

Will also want to run some command similar to the following and possibly need a new vagrantfile in a new directory:

```vagrant box add vmware_box packer_vmware-1_vmware.box -f```

Further information can be found here:

https://www.vagrantup.com/docs/vmware/

A license is required:

https://www.vagrantup.com/vmware/#buy-now
