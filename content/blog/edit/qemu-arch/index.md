---
# type: docs 
title: Virtualize with Qemu on Arch Linux
date: 2022-12-06T14:48:52-05:00
featured: false
draft: false
description: Easily virtualize Windows or any other OS with QEMU.
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["virtualization", "windows", "Linux"]
images: []
---

## Installing 

These instructions are for Arch Linux, but I'm sure you can get it working on any other distro since KVM and QEMU are built in kernel modules. 

```shell
sudo pacman -S qemu-full virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libguestfs

```
That installs all the packages you need plus a front end graphical interface. (virt-manager)

Now start the libvirtd service:

```bash
sudo systemctl start libvirtd
```
Enable it on startup:

```bash
sudo systemctl enable libvirtd
```
Edit: `/etc/libvirt/libvirtd.conf`

Uncomment the follwing lines:

![libvirtd](images/qemu/libvirtconf.png)

Now add your user to libvirtd group:

```bash
sudo usermod -aG libvirt USER
```
You might have to log out and back in for the changes to take effect.

Restart libvirtd service:

```
sudo systemctl restart libvirtd.service
```
## Let's install windows

Download [windows 10](https://www.microsoft.com/en-us/software-download/windows10ISO).

Open up virt-manager, make sure QEMU/KVM is connected:

![virt](images/qemu/virt.png)

Go to edit then preferences and check "Enable XML editing".

![xml](images/qemu/xml.png)

Click create a new virtual machine and browse local and click browse again and find the windows 10 machine you downloaded.

![browse](images/qemu/browse.png)


![local](images/qemu/local.png)

Then customize the virtual machine to your liking, don't use more than half of your cpu cores. Click "customize configuration before install".

![customize](images/qemu/customize.png)

On the overview section go to the XML tab and delete these two lines:

![delete](images/qemu/delete.png)

Change this line to yes:

![yes](images/qemu/yes.png)

And click apply. Now go to SATA Disk 1, Details and change it to VirtiO:

![virtiO](images/qemu/sata.png)

Do the same to the NIC:

![nic](images/qemu/nic.png)

And now download the fedora windows virtio [drivers](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-2/) choose the "virtio-win.iso".

Now go back to virt-manager and click add hardware, storage , CDROM drive. 

![cdrom](images/qemu/cdrom.png)

Go to the newly created SATA CDROM 2 and add the virtio-win.iso. Now click begin installation. 

It'll ask you for a product choose, you don't have one. Pick your windows version and click custom install:

![custom](images/qemu/custom.png)

click load driver and click ok and choose the windows 10 driver:


![driver](images/qemu/driver.png)

And finally choose the virtual storage and install. Wait for it to finish and we're almost done, just a couple of more tweaks once its installed.

Once you're  finally done installing open up the windows explorer go to this pc click cd drive E and install both of these:

![driver](images/qemu/install.png)

And that's it you're done. 
