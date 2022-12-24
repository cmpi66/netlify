---
type: docs 
title: Update Gentoo Kernel
date: 2022-12-13T06:56:19-05:00
featured: false
description: A brief article on upgrading your Gentoo kernel. 
draft: false
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["Gentoo", "Linux", "Kernel"]
images: []
---

If you've  read my gentoo article and you were conviced to try out getnoo then heres a guide on how to update your kernel whenever you instll a newer version.


First update to the latest kernel sources if they weren't  pulled in by an update: 

```shell
sudo emerge --ask sys-kernel/gentoo-sources
```
Its best to do everything as root from this point forward. Sometimes a kernel compile can take a while and your sudo privelages can expire during a compilation therefore it'll fail. Now go to your current kernel config and make a copy of it:

```
cp -ir /usr/src/linux/.config ~/$(uname -r).config
```
View and then select the new kernel:

```
eselect kernel list 
```

```
eselect kernel set 2
```
Usually, the newest kernel will be the last one if you only have tw installed. But if you have more than two just select the number corresponding the version you're upgrading to.

Go to new kernel and make clean directory:

```
cd /usr/src/linux/ && make mrproper
```

This commands just runs a make clean command to prep the kernel.

Now copy your backup file to new kernel dir:

```
mv kernel.config /usr/src/linux/.config
```
If you're upgrading from an old kernel then you might want to make some customizations:

```
make menuconfig
```
Then to keep your settings run:

```
make olddefconfig
```

Make sure your boot drive is mounted in the correct place. Then run:

```
make modules_prepare

```

And now to build the kernel, if you've  compiled your own kernel then you already know the command:

```
make -j7 && make -j7 modules_install && make install && emerge @module-rebuild && grub-mkconfig -o /boot/grub/grub.cfg
```


The `-j7` means how many threads the command should use, since I have 8 in my machine I use 7 so I can have 1 more for other tasks. Use the amount that your system has. The `emerge @module-rebuild` is necessary if you have any nvidia drivers, virtualbox modules or v4l modules in your kernel. If you don't have either then you need the command. 

Now you can reboot and you'll see your kernel is up and running.
