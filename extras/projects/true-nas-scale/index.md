---
# type: docs 
title: True Nas Scale
date: 2022-11-30T13:12:17-05:00
featured: false
draft: false
description: Virtualize Truenas at home with QEMU.
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["Linux","NAS", "backup", "self hosted"]
images: []
---

In this guide I'll show you how you can virtualize Truenas Scale in a QEMU vritual machine on your local Linux Machine. Truenas requires 8-16gb of ram and a dual core cpu, so if you don't have those resources to spare then this guide is not for you. You can still install it and play around with it. You'll need a pair of hard drives with identical capacity. 

(**MAybe add the macvtap command**)


## Setting up the Virtual machine

First install QEMU, I have a guide on how to do it on Arch Linux [here]. The setup is almost the same across all LInux distributions since KVM is built into the kernel. Download the latest version of  Truenas scale from [here](https://www.truenas.com/download-truenas-scale/). 

Open up virt manager and create a new virtual machine, choose local and add the truenas scale iso. Choose **generic linux** under type:

![generic linux](images/truenas/generic.png)

Then add at least 2 cores, 8bg, and 25gb storage, then click customize before install. 


Run `lsblk` on your local machine to find the hardrives your going to use. Then run `lsblk -o +MODEL,SERIAL` to get the ids of the drives. Once you have their ids go back to the virtual machine and click add hardware, **storage**, **custom storage** and add the path to the ids of your drives `/dev/disk/by-id/IDOFDISK` Do this for both disks. Make sure you choose SATA as the bus type.

![disk by id](images/truenas/disk-id.png)
**The highlighted portion is the id you would use** 


![qemu disk](images/truenas/qemu-disk.png)

## Configuring truenas

Now you can begin the installation. Choose the install/upgrade installation and install it on the 25gb virtual hard drive we created. Choose the admin user and create a password. After that it'll start installing, reboot it after its done. It'll spit out an IP address to access the web interface once it boots back up.

On the web portal login as admin and the password you created. Let's create our storage pool. Go to storage, then click create pool, you'll see your disks, go ahead and select them and move them over the right and name your pool. 


![qemu disk](images/truenas/pool.png)

And now let's add a share to access our pool, we'll be adding an NFS share for Linux, but there are a bunch more. You can configure them as you like over time. 

First create a user, go to credentials, then local users:

![users](images/truenas/users.png)

Create a dataset, go to storage and click **create dataset** ,name it whatever you want, choose the default settings:

![dataset](images/truenas/dataset.png)

Edit the permissions to the dataset scroll to the bottom and you'll see **edit permissions** then click **set ACL** click create a custom ACL and add item:


![perms](images/truenas/perms.png)

![acl](images/truenas/acl.png)


Now go back to shares, pick NFS, choose the folder you created and add the network that'll be allowed to access the share:


![nfs](images/truenas/nfs.png)












Truenas scale is so much more than a NAS, it can run virtual machines and containers, but that's not the focus of this article. If you want to find out what else Truenas can do, read their documentation.
