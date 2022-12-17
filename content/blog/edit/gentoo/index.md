---
# type: docs 
title: Gentoo
date: 2022-12-01T08:35:45-05:00
featured: false
draft: false
description: A very brief and gentle introduction to Gentoo Linux.
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: ["linux, gentoo", "open-rc"]
tags: ["gentoo", "linux"]
images: []
---

Many people who use Linux have heard of Gentoo and might have some misconceptions about it. I'm here to clear them up. First off Gentoo is more than a regular Distro like Arch, Ubuntu, Fedora, etc. Gentoo is more than that, think of it as a distro within a distro. Most Linux distros are desktop OSs but Gentoo can serve a variety of different purposes, that's  why it can support many different architechtures.

## The power of choice 

Many people proclaim the reason they switched to Linux was because of the power of choice in software and customizability. Now that is a *huge* benefit to Linux when compared to Windows. But Gentoo takes it to an entirely different level. 

In gentoo you can choose what init system you want to use. *That* on its own is a big deal. If you're  been on Linux long enough then you're  aware of the beef between systemd and other init systems. This article isn't about that issue specifically, but if you don't want systemd then you can run open-rc.

Packages on Gentoo are also installed differently. Since Gentoo is a source based Distro you're able to customize each and every package according to your needs and your computer hardware. Gentoo does this with USE flags. USE flags are commands you can use on a per package basis or on a system wide config. Let's say you don't want anything systemd related on your machine, in your `/etc/portage/make.conf`, in the USE category, insert `-systemd`. That's it. You can do the same with anything else, for example you don't want anything `gnome` or `kde` on your machine, since a lot of Packages have gnome and kde built in you can just `-gnome -kde` in your make.conf. 

By utilizing USE flags this makes your machine faster since applications aren't as bloated as regular binaries that come with generic settings that are meant to work on all distros. Your machine also consumes less resources.  And it has a smaller surface area of attack even though Linux is still one of the most **secure** operating systems out there. 

The con to all this customizability is that Packages are compiled, which means they will take longer to install than a package from a binary distro.


## The kernel rabbit hole

And lastly, the kernel.  Many people's favorite reason for running Gentoo is comiling their own kernel. By compiling your own kernel you're  able to turn off **a lot** of settings that aren't applicable or neccessary for your hardware. Turns out the Linux kernel is pretty bloated, since practially the world runs on Linux. If you have an Intel based system, then there's no need to have any AMD settings/modules built into your kernel. And when you compile your kernel you get to learn so much about Linux and how ubiquitous it is.



