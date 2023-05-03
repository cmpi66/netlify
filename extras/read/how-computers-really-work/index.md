---
# type: docs 
title: How computers really work
date: 2023-04-29T18:03:08-05:00
featured: false
draft: false
description: How to run your own git server.
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

Make sure you have a VPS server. If you haven't made one, look at my [webserver tutorial](https://www.munozpi.com/completed-projects/webserver/#post-content-body), you can create one in 3 minutes or less. 

## Installing and configuring

Login into your server: `ssh USER@IP` and install git: `sudo apt install git` 

Add a git user: `sudo adduser git` 

Switch to the git user: `su git`

Create a .ssh dir `mkdir .ssh`

Change the permissions to that dir: `chmod 700 .ssh/`

Then create an file where your ssh keys will go: `touch .ssh/authorized_keys`

Now change the permissions to the keys file:`chmod 600 .ssh/authorized_keys`

Go back to your local machine and get the ssh key, if you don't have one, generate it with: `sshkey-gen -t rsa -b 2048`. Run: `ssh-copy-id git@IP` after that you'll be able to login without a password.  

Go back to your server and paste your id_rsa.pub into `.ssh/authorized_keys` Now you should be able to log into your server as the git user without a password.

## adding your repos

Go ahead and create the git directory with your ROOT user: `mkdir -pv /srv/git` Change ownership to the git user: `chown git:git /srv/git/`

Change directory to the git folder and become the git user. Everything is ready, all you need to do is add your repos. 

The way it works is you add individual directories for each of your repos. Example: we have dotfiles repo we want to push, first, `mkdir dotfiles.git` then `cd dotfiles.git` and `git init --bare`. If you want the inital branch to be main run: `git init --bare --initial-branch=main` or the branch your repos uses. 

Now go to your local machine and edit your dofiles repo remotes: `git remote add <NAME> git@YOUSERVERNAME:/srv/git/dotfiles.git` Now you can push your repo to whatever you named your remote. Let's say you named it `home`, you would run: `git push home <BRANCH NAME>`. 

Go back to the server and run `git log` in the dotfiles repo and you'll see all your past commits. Now anyone can clone your repo from that URL by running `git clone git@YOUSERVERNAME:/srv/git/dotfiles.git`. 

And that's it, you now have a remote git server, if you want you can go further and turn into a web server where you'll be able to see all the commits by loading up a web page. But that's  for another day. 
