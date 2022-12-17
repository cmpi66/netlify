---
# type: docs 
title: Git Server
date: 2022-11-29T18:03:08-05:00
featured: false
draft: false
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["git", "self hosting"]
images: []
---

A quick tutorial on setting up your own git server.

<!--more-->

## Create a server

Make sure you have a vps server. If you haven't made one, look at my [webserver tutorial](../webserver/index.md), you can create one in 3 minutes or less. 

## Installing and configuring

Login into your server: `ssh USER@IP` and install git. 

Add a git user: `sudo adduser git` 

Switch to the git user: `su git`

Create a .ssh dir `mkdir .ssh`

Change the permissions to that dir: `chmod 700 .ssh/`

Then create an file where your ssh keys will go: `touch .ssh/authorized_keys`

Now change the permissions to the keys file:`chmod 600 .ssh/authorized_keys`

Now let's go back to our local machine and get our ssh key, if you don't have one generate one with: `sshkey-gen -t rsa -b 2048`. Now run: `ssh-copy-id git@IP` input your password and after that you'll be able to login without a password.  

Now go back to your server and paste your id_rsa.pub into `.ssh/authorized_keys` Now you should be able to log into your server as the git user without a password.

## adding your repos

Go ahead and create a directory with your ROOT user: `mkdir -pv /srv/git` Change ownership to the git user: `chown git:git /srv/git/`

Change directory to the git folder and become the git user. Now everything is ready all you need to do is add your repos. The way it works is you add individual directories for each of your repos. Example: we have dotfiles repo we want to push, first, `mkdir dotfiles.git` then `cd dotfiles.git` and `git init --bare`. If you want the inital branch to be main run: `git init --bare --initial-branch=main` 

Now go to your local machine and edit your dofiles repo remotes: `git remote add <NAME> git@YOUSERVERNAME:/srv/git/dotfiles.git` Now you can push your repo to whatever you name your remote. Let's say you named it `home`, you would run: `git push home <BRANCH NAME>` And that's it. 

Go back to the server and run `git log` in the dotfiles repo and you'll see all your past commits. Now anyone can clone your repo from that url by running `git clone git@YOUSERVERNAME:/srv/git/dotfiles.git`. 

And that's it, you now have a remote git server, if you want you can go further and turn into a webserver where you'll be able to see all the commits by loading up a webpage. But that's  for another day. 
