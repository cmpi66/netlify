---
type: docs 
title: Ansible
date: 2022-12-05T18:03:57-05:00
featured: false
draft: false
description: A primer on the power of automation with Ansible.
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["Linux", "automation"]
images: []
---

## Let's get started

This is going to be a short blog to get you started with Ansible and its amazing powers.

First let's go to [vultr](https://vultr.com) and create ourselves three servers. Don't worry it won't cost you much because we'll destroy them after we're done. Choose the cloud compute and regular intel performance options. Pick the location closest to you physically for best performance.


Create a centos 9 server and two ubuntu 22.04 servers. They'll take a bit to deploy so be patient, keep an eye on the consoles. Once centos is ready restart it through vultr's interface so you can SSH into it.

SSH into your centos box first with `ssh root@ipaddress`.

Then run `yum update -y && yum install epel-release -y && yum install ansible -y`. 

The first command is updating the repos, the second is adding the repo with Ansible and the last one is installing Ansible.

## Get to know your ansible files

Navigate to `/etc/ansible`. For right now we're only using hosts and ansible.cfg, don't worry about the roles directory. In the ansible directory run `ansible-config init --disabled > ansible.cfg` to generate a full commented out config. Your hosts file is where you put the information for all you linux boxes, aka their ips, users, and passwords/sshkeys. For this brief tutorial we'll be using the root user and a passwrod authentication method. **This is only for the tutorial never use root and always use ssh keys.** 

Open up the hosts files with either nano or vim. Now let's add the ips and passwords of the two ubuntu boxes we created.

Your hosts file should look like this

![hosts](images/ansible/hosts.png)

Notice how we can define a group by naming it and surrounding it in square brackets. We could have also created another variable called `[linux:vars]` and put our login credentials there, but since the passwords for the servers are different and we're not using ssh keys it's best to do it this way. Now go into your `ansible.cfg` and uncomment the line `host_key_checking=true` and make it False.


And that's it. You're  ready to use ansible. Let's try out some commands: 

## A few commands

Let's ping our boxes, `ansible linux -m ping`. 

The syntax is pretty easy to understand: you have the `ansible` command, then the `linux` to specify the hosts/group, `-m` to specify the module and finally a `ping` command. Also when you run an ansible command you'll notice it gathers facts about the machines.


![facts](images/ansible/facts.png)


## Playbooks

This is where ansible shines. With a playbook you can design your Linux servers, network routers, and more to have everything you need. For example we can make sure all our Linux boxes have neovim installed. Here's a quick script to get us going. 

```yaml
---
  - name: neovim
    hosts: linux
    tasks:
      - name: install neovim
        apt:
          name: neovim
          state: latest


```

Ansible uses yaml for its playbook files so create a neovim.yaml file with the above script. So as you can see the script is straightforward, the first `name` varialbe is the name of our script, the `hosts` is the host we're using, then `tasks` is what's  going to be done, `apt` is the package manager for ubuntu and finally `name` is what we're installing and `latest` is the latest version.

Now run the script with: `ansible-playbook neovim.yaml`

As you can see neovim was installed on both servers. You can see from the "changed=1" result.


![playbook](images/ansible/playbook.png)

And if you run the playbook again, you'll see "changed=0" instead. Pretty amazing right. Now let's revise the script to remove neovim; change `state: latest` to `state: absent`. 


```yaml
---
  - name: neovim
    hosts: linux
    tasks:
      - name: install neovim
        apt:
          name: neovim
          state: absent


```


And there you have it, a simple ansible tutorial. There's so much that you can do with it, you can automate almost anything. 
