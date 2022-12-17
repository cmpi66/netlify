---
# type: docs 
title: The Linux File Structure
date: 2022-12-01T14:33:55-05:00
featured: false
draft: false
description: An overview on the Linux file structure.
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["Linux","CLI"]
images: []
---

This article will help you understand the Linux Root file structure. 

Let's change directory into `/` and `ls`. Here you'll see a bunch of directories and you might be a little confused but don't worry, its all self explanatory. 

## /bin

Unlike windows Linux keeps all its basic programs aka binaries in the bin directory. These are the basic command line programs: `ls``cd` `touch`.


## /boot

This directory is where you would mount your boot partiton, now if you used a gui Linux install then this is done automatically. But on a Gentoo or Arch install you would partiton the the drive and mount the boot partiton on /boot. Don't mess this file or else you'll render your system unbootable.

## /dev

The dev dir is shorthand for devices. This is where all your connected devices like your webcam, keyboard, and mouse reside.


## /etc

This is one of the most importatn directories of your entire Linux system, it's where most system default settings are located. Many applications also put a defualt config file here, like zsh: `/etc/zsh/zprofile`.

## /home

The home dir is where all the local users and their personal configurations are stored. Most people should already know this one.

## /lib and /lib64

Not all Linux distros will have both of these, all they have are binaries for our applications.  


## /lost+found


## /media

Media is where your removable media information gets stored: any usbs, ereaders, etc.


## /mnt

The mnt aka mount directory is where you would manually mount any drive that doesn't mount automatically in the `/media` directory. 


## /opt

The opt aka optional dir is where you have drivers from vendors, some web browsers will also have some data here too.


## /proc

All the proccess you have running are located here. They organized by numbers (process ids) instead of names. If you run `top` you'll see the numbers correspornd to a process.  

## /root

The root's users home directory. You need to be root to access it. It's used as a fallback in case your home folders messes up for whatever reason. 


## /run

This is a temporary directory that's created every time a user logs in. So once the system is shut off it dissapears, its a cache of certain services: dhcp, system files, printer set up and more.


## /sbin

System binaries are kept here, basically all the tools that a system administrator needs to use. For example the `mkfs` command which turns a drive into certain files systems is an administrator tool. Obviously you need root privileges to run any of these.


## /sys

This is where your kernel lives. Usually, regualr users woudlnt mess with this folder at all. Even if you're  a gentoo user and you're  compiling your own kernel, you wouldn't access it from here since its also a temporary directory like `/run`.


## /srv

This folder is used mostly for Linux servers. Any services you would run as a linux box would be put in here.


## /tmp

The temporary directory will store all data on running programs. If you're editing a file that you haven't saved, a copy of that file will be saved in here. This way you can easily recover your document if the program crashes.


## /usr

This where applicaiion binaries are located for the current user. Unlike `/bin` `/sbin` which are available for ALL users.


## /var

This is the variable directory where package manager information and system logs are contained. 
