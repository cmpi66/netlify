---
# type: docs 
title: Rdp From Linux
date: 2022-12-02T14:24:48-05:00
featured: false
draft: false
description: Learn how to RDP to a windows machine from Linux.
comment: true
toc: false
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["Linux", "Windows"]
images: []
---

In this guide you'll learn how to use Remote Desktop from your local Linux machine to a remote Windows machine.

All you need is one app: `sudo apt install remmina`

If you're on Gentoo like I am `sudo emerge -a net-misc/remmina`

Now if you're not on a Debain based distro or Gentoo, I'm sure your package manager has it. Its a basic utility. 

Go ahead and open the app. At the top left corner click the add button, name it and choose rdp.

![rdp](images/rdp/rdp.png)

## What the options mean

- Server = the IP address of the windows 10 machine, you can get this by opening the windows command prompt and running ifconfig

- username = is the user you're  trying to conncet to 

- password is the password of that user 

- Domain, we can skip this one for now, most people won't need this

You can leave almost everything else at default and try them out at your own time.

![rdp](images/rdp/rdp.png)

Once you're  done click save and connect, click yes when it asks to trust certificate and then that's  it. You've successfully logged into windows with Linux. 

The resolution is something you're going to have to tweak and figure out for yourself, on my 1080p monitor I configure rdp to a 1400x900. Other than that it works perfectly, now you don't need a windows machine to log into windows.

![rdp](images/rdp/windows.png)
