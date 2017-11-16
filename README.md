# MineOfficeAppliance
Methods for installing the Mine Office Appliance on a new machine

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

If this is the case, you will need to add the Zscaler certificate to a system environment variable `SSL_CERT_FILE`.

The install command should then work.
