---
# type: docs 
title: Ubuntu server Kubernetes
date: 2022-11-28T16:57:33-05:00
featured: false
draft: false
description: A brief guide on how to install Kubernetes on a Raspberry pi
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: ["Kubernetes","Linux"]
tags: ["Kubernetes","Linux"]
images: []
---

This is a guide that'll help you install Rancher, docker and Kubernetes on an ubuntu server inside a QEMU virtual machine. .


Once your logged into your server run the docker install command, this command may change so be sure to check the [docs](https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/installation-requirements/install-docker)

```
curl https://releases.rancher.com/install-docker/20.10.sh | sh
```

Then add your user to the docker group:

```
sudo usermod -aG docker USERNAME

```
Then run `docker version`, to make sure you can use docker as a non-sudo user.


Log out and log back in so the change will take effect. Then create a new file in `/etc/sysctl.d/99-kubernetes.conf` and put this line in the file:

```
net.bridge.bridge-nf-call-iptables=1
```

## installing rancher

Let's install rancher with the following docker command:

```
sudo docker run --privileged -d --restart=unless-stopped -p 80:80 -p 443:443 -v /opt/rancher:/var/lib/rancher rancher/rancher

```
You'll get a certificate warning go ahead and click advanced and accept the risk since we were the ones who created it.

![cert](images/kubernetes/dash.png)

Then you'll notice a welcome screen asking you to run a command to get temporary password, go ahead and run the docker command.

![docker pass](images/kubernetes/docker-command.png)


Once that's done create your own password and you'll be in the dashboard.


![pass](images/kubernetes/new-pass.png)


![dashboard](images/kubernetes/dash.png)


You'll notice that we already have a cluster created for us out of our virtual machine called local. On this cluster we can deploy our docker containers. We'll leave that for the next artilce where I show you how to deploy pihole inside kubernetes.

