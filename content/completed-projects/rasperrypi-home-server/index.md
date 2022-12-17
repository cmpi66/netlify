---
# type: docs 
title: Rasperrypi Home Server
date: 2022-11-27T08:24:03-05:00
featured: false
description: Turn your Raspberry Pi into a home server with docker and portainer. 
draft: false
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["Raspberry pi", "Linux", "self hosted" ]
images: []
---

In this guide I'll show you how you can turn a Raspberry Pi 4 into a small home server to self host a bunch of services with docker and portainer. In case you don't know what docker is, its a way to containerize applications, and keep them seperate from each other. For example an app could need dependcy X ver1 and then another app could need that same dependcy but version2, that'll cause conflicts and you won't  be able to run both apps on the same machine. But with docker you can spin up multiple containers that don't conflict with eachother. 


Containers also require less resources to run so with a small Rasperry pi we can run a decent number of services without it straining the PI. In this guide I'll be using a Rasperry pi 4 with 4gb ram. 

## Install raspberry pi OS and docker

First download rpi-imager on your local machine and install raspberry Pi OS lite (32bit). Click the gear icon, enable SSH and create a pasword for the pi user. Make sure you're Pi is conncected through an ethernet cable for best performance.

Once that's finished ssh into your pi:

`ssh pi@IP`

Update the pi:

`sudo apt update && sudo apt upgrade -y`

Reboot the pi after the upgrades. After its back up install docker:

```bash
curl -sSL https://get.docker.com | sh
```
Add the user to docker group:

```bash
sudo usermod -aG docker USERNAME
```
Logout and log back in for the changes to take effect. Run `docker version` to make sure you can run docker without sudo.

Install portainer with docker:

```
sudo docker pull portainer/portainer-ce:latest
```
```
sudo docker run -d -p 9000:9000 -p 9443:9443 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

```

The first command is pulling the latest portainer image. The second command is what's running the image with docker, its mapping the ports, and mapping the data drives from our raspberry pi to the container. Don't worry once its done you won't  have to use command line to run docker, you can use the portainer web interface to launch your containers. But you should learn how to spin up docker contaiers through the command line.

Run `docker ps` and you'll see the active containers, we only have one. With your ip address go to the portainer UI: 

```
https://10.27.27.24:9443
```
We're connecting on the 9443 port we mapped earlier, you'll get a certicate warneing, click advaced and accept risk and continue. The reason your getting that is because we created a self-signed ssl certicate.

Create your username and password and now your in. Click **get started** and you'll see your raspberry pi instance, click on it and go to containers and portainer itself will be a container. This is where all your containers live. 

![portainer](images/rpi-docker/portainer.png)

![local](images/rpi-docker/local.png)

## installing containers

Let's add an application list that'll give us a bunch more apps to add. Go to settings on the bottom left, add this template then save settings:

```
https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/template/portainer-v2-arm32.json
```

![local](images/rpi-docker/template.png)

Go to app templates and now there's a bunch of apps that you can install. I'll just go over installing one for now. You can choose and play with the rest on your own time.

Let's do a simple dashboard where we would have quick access to all our containers. 

Go to app templates and search for heimdall click on it and open up the advaced settings. These are the settings that we ran earlier on the command line. Here is where you can change port numbers and where you would map the application data. For now leave everything on default and click deploy container.

![heim](images/rpi-docker/heim.png)

![config1](images/rpi-docker/config1.png)

![config2](images/rpi-docker/config2.png)


Once its deployed you can navigate to it on the same IP as the portainer instance except with the port numbers it chose, **7203**

Let's add our portainer instance on the dashboard click add application and portainer, add the url from earlier `https://10.27.27.24:9443
` with your IP obviously, save it and that's it. Now you'll be able to navigate to portainer from the heimdall dashboard. Think about how useful it'll be once you get a few apps running. 

![add](images/rpi-docker/add.png)

![done](images/rpi-docker/done.png)

And that's how you turn a raspberry Pi into small home server to self host a bunch of apps. 
