---
# type: docs 
title: Vultr Wireguard
date: 2022-11-28T16:58:33-05:00
featured: false
draft: false
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["vpn", "security", "linux"]
images: []
---

A quick and easy way to set up wireguard on a remote server.

<!--more-->

Today I'm going to teach how to make a VPN so you can use it to ssh into all your servers. That way you'll secure your servers and only allow connections from the VPN. 

## Create a vps

Let's go ahead and create an ubuntu server at [vultr.com](https://vultr.com). Choose cloud compute and intel regular performance so you can get a cheap $5 server, also pick a location that's  closest to you physically. Deploy the server and wait for it to be ready, it'll take a few minutes.

After its done get the IP and password and log into your server with `ssh root@IP`. Reboot the server if it tells you, then log back in and update it: `apt udapte && apt upgrade -y`. Then install wireguard `apt install wireguard`. 

## install wireguard

Next run this script `wget https://git.io/wireguard -O wireguard-install.sh && bash wireguard-install.sh` and answer the prompts. Choose the defualt port, you can choose whatever dns you want. After that your config file will be ready. Copy the config file to your local machine with `sftp root@IP` navigate to the directory where the config is in your server, itll be in `/root/nameyouchose` then just run `get nameyouchose`.

(explain wireguard conf here mention IPv6)


Go back to your local machine and install wireguard as well. Then change to your root user and move the config file to `/etc/wireguard/nameyouchose`.

And now run wireguard, here are the main commands:

- `sudo wg-quick up nameyouchose` to activate vpn 

- `sudo wg-quick down nameyouchose` to deactive vpn 

- `sudo wg` to see the status of the vpn

Activate your vpn and then run `curl ifconfig.me` and you'll see your IP address is now the VPS's. Or you can go to [whatismyip.com](https://www.whatismyip.com/). With this you can deny all ssh connections besides the VPN to your other servers for extra security. Let's do that now. 

![ssh ip](images/wireguard/server.png "Logged into server you can see it's IP")


![ssh ip](images/wireguard/changed-ip.png " Now you can see my local machine is using the server's IP")

## ssh harden

Log on to your other server and edit the `/etc/ssh/sshd_config` Add this line to the end of your file:

`AllowUsers *@149.28.37.180` obviously you would use your wireguard server IP.You can read more about ssh hardening [here](https://www.digitalocean.com/community/tutorials/how-to-harden-openssh-on-ubuntu-20-04) 

Then reload the ssh daemon by running `sudo systemctl restart sshd.service`. Don't close the current connection yet open up a new terminal, de-activate the wireguard VPN if you have it activated, now try logging back in, you should be denied. Now re-active the VPN and try logging in, and it should work. That's it now you have a VPN that you can use to secure all your servers. 




