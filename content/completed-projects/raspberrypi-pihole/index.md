---
# type: docs 
title: Raspberrypi Pihole
date: 2022-11-28T16:45:07-05:00
featured: false
draft: false
description: Block ads network wide on your Raspberry with pi-hole.
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["Linux","self hosted","Raspberry pi"]
images: []
---


## Installing RPI OS

First download RPI-imager on your local machine and install Raspberry pi OS choose Raspberrypi os (other) and flash your SD card with Raspberry pi OS Lite (32-bit).


Click the gear icon and enable SSH and input your password. If you don't have an Ethernet cable connected to your Pi, this is where you can add your WiFi settings.


Once that's done reboot your Pi with your and SD card connected. Get its local IP from your router and SSH into it with `ssh pi@IP` or whatever username you chose.

## Installing pihole

Before we install pihole let's update the pi first:

`sudo apt update && sudo apt upgrade -y`

Now install pihole:

```
sudo curl -sSL https://install.pi-hole.net | bash
```
Follow the prompts and choose the defaults for now, we'll change some settings later on. Make sure you install the web interface, this is where we'll change and update or settings.

Once its done it'll give you instructions on how to acces the web interface and how to change your password:

`pihole -a -p NEWPASSWORD`

Let's go to our web interface and check if its running:

![pihole](images/pihole/pihole.png)

## Configuring Unbound

Install unbound to make pi-hole your dns server:

`sudo apt install unbound`

Create the config file:

`sudo nano /etc/unbound/unbound.conf.d/pi-hole.conf`

Copy the example config from the [pi-hole website](https://docs.pi-hole.net/guides/dns/unbound/) and paste into the new file we opened with out previous command.

The following commands are in the unbound documentation, but to simplify it I'll paste the commands you have to run only, read the documentation to understand more of what they're doing.

`wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints`

Restart the unbound service:

`sudo service unbound restart`

Then check your dns queries:

`dig pi-hole.net @127.0.0.1 -p 5335`

Make sure you get a "NOERROR": 

![dig](images/pihole/dig.png)

Then run the last two commands:

```
dig fail01.dnssec.works @127.0.0.1 -p 5335
```

```
dig dnssec.works @127.0.0.1 -p 5335

```

You should get a "SERVFAIL" output on the first command:

![servfail](images/pihole/servfail.png)

Then on the second command you should get a "NOERROR" output:

![noerror](images/pihole/works.png)

Finally go to the pi-hole web interface and go to settings then DNS and uncheck the default DNS servers and use your localhost address with port 5335:

To make pi-hole your dns server to block ads, you have to go to your routers settings, add a custom DNS server and use the pi-hole's IP address. Since almost all routers have a different way of doing that I can't really show you. But the steps are generally the same.
