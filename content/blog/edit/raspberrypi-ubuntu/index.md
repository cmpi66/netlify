---
# type: docs 
title: Raspberrypi Ubuntu
date: 2022-11-28T16:46:05-05:00
featured: false
draft: false
description: Use Ubuntu server on Raspberrypi.
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["raspberrypi", "Linux", "self hosting"]
images: []
---

## Download rpi-imager

First download the [rpi-imager](https://www.raspberrypi.com/software/).   

Open it up and click choose OS, go to "other general-purpose OS" and you'll see ubuntu. If you have a raspberrypi 4 with 4GB or more of ram you can use 64 bit if not choose 32bit. Now pick "ubuntu server 22.04 LTS".

![ubuntupi](images/ubuntu-rpi/ubuntupi.png)

Choose your sd card for storage and click write. Once its done and you've  powered on the raspberrypi, give it some time for ubuntu to do its thing, since it has a few install scripts that it always runs. 

Now find your pi's IP address by going to your router settings and finding connected devices. 

Then: 

```bash
ssh ubuntu@IP
```

The password is ubuntu. It'll prompt you to change the password and then immediately log you out. Log back in with your new password and that's it. You now have an ubuntu server on your raspberrypi.

![connecting](images/ubuntu-rpi/connecting.png)

![connected](images/ubuntu-rpi/connected.png)
