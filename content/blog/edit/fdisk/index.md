---
# type: docs 
title: Fdisk tutorial
date: 2022-12-01T07:53:45-05:00
featured: false
description: A brief tutorial on Linux's fdisk utility.
draft: false
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["Linux", "Gentoo", "Arch"]
images: []
---

In this tutorial Ill show how you can use fdisk to partiton your drives. 

## Commands

First list out your disks with: `sudo fdisk -l`. Now you can see all the drives connected to your machine and where they're  mounted. For example on my set you can see my main disk is /dev/sda, it has 3 partitions and they all play a different role: /dev/sda1 is my boot partiton, /dev/sda2 is the swap and /dev/sda3 is the root partition where ally data is located. Don't worry if your drives are named differently, NVME drives start as /dev/nvme0n1. 

![fdisk output](images/fdisk/fdisk-output.png)

You can also run lsblk to get mount point information. 

![lsblk](images/fdisk/lsblk.png)

Now let's play around with our drives. **Warning make sure you have the CORRECT drive's name before you input any commands, you could end up wrecking your whole system**.

Let's re-create my /dev/sda/ since the structure of it is what you would need when installing a new Linux distribution through the command line, like Arch or Gentoo. Go ahead and switch to your root user since all these commands require `sudo`, its much easier to just be root. 

```bash
fdisk /dev/sdb

```
Run the `p` key to display the partitions:

![partitions](images/fdisk/partitions.png)

This is my backup drive but its empty for now so I'll blow away all the partitions. To do that we press the `d` key to delete. Now you can see that partition doesn't exits. (If you make a mistake just exit fdisk, changes won't  be written unless you use the command to write them.)

![deleted partition](images/fdisk/deleted-partition.png)

Now the boot drive first: type the `n` key to create a new partition, pick partition `1`, first sector default and last sector add `+256M`. This means our boot drive will be 256MB.

![boot partition](images/fdisk/boot.png)

Turn it into an EFI partition by pressing the `t` key and choosing `1` for the efi option. 

![efi partition](images/fdisk/efi.png)

Create the swap: press `n` press `2` for second partition hit "enter for the first sector" and the amount of ram you have for last sector `+16G`. Now press `t` for type choose partition `2` and choose type `19`

![swap partition](images/fdisk/swap.png)

And lastly create the root partition: `n`, press `3` for third partition and choose defaults for first and last sector which will take all the reaming disk space.

![root partition](images/fdisk/root.png)

And now your disk should look like this:

![all partitions](images/fdisk/all.png)

Press `w` to save the changes.


## Adding filesystem

Now we need to create the files systems for the boot and root partitions. 

For the boot partition:

```bash
mkfs.vfat -F 32 /dev/sdb1

```
This turns our EFI system partition into a FAT32 filesystem.

For root:

```bash
mkfs.ext4 /dev/sdb3
```
With this we're turning it into an ext4 filesystem and remember our root partition is the third partition.

And now to activate our swap partition. (FYI swap isn't really necessary but it's good to know to create and configure one.)

```bash
mkswap /dev/sdb2 

```
Activate it:

```bash
swapon /dev/sda2

```
And that's it. You learned how to use fdisk to partition and configure a hard drive.
