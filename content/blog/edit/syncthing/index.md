---
# type: docs 
title: Sync your files across multiple devices with Syncthing
date: 2022-11-30T14:58:06-05:00
featured: false
draft: false
description: A short guide on how to use syncthing.
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["linux", "backup"]
images: []
---

Syncthing is an open source program that let's you sync files accross multiple devices. This is a lifesaver if you want to have a backup computer with all your files and settings just in case your main machine goes down.

## Installing

First let's install syncthing on both of our machines: 

Arch `sudo pacman -S syncthing`

Ubuntu `sudo apt install syncthing`

Fedora `dnf install syncthing`.

## configuring

After its installed run it for the first time in a terminal on your main machine: `syncthing`. It'll open up a webpage with address of localhost:8384. Do the same for the other machine so they can automatically pick up on each others ID's for later.

![syncthing](images/syncthing/syncthing.png)

It'll prompt you to set a password, go ahead and do it. 

By default Syncthing creates a folder called Sync in `~/Sync` you can use that folder to sync your files. Or what I do is sync every separate directory I want both computers to have. As you saw I have three directories I'm syncing, that means those folders have to exist separately wherever I choose to create them.

Let's create a test folder: on our local machine first `mkdir ~/test`. NOw back on Syncthing's home page click "add folder" and fill it out like so:


![test dir](images/syncthing/making-test.png)

On the sharing tab you'll see the ID of the other computer pop up go ahead and choose it, if you don't make sure you have syncthing open on both computers and you'll see it populate.

Now under file versioning I recommend you pick "trash can file versioning" for 15 days, all this means is that even if you accidently delete something it won't be permanently deleted until after 15 days.  

![trash](images/syncthing/trash.png)

Leave "ingore patterns as default". 

And finally on the advanced tab make sure you have it like this:

![advanced](images/syncthing/advanced.png)

- You want to make sure the folder syncs the newest files first

- You also want it to send and receive new changes if your using both computers interchangeably 

And that's it, click create and now go to your other machine. 

You should see a pop-up on the other machine asking you to add the folder, click add and give it the same options as the other folder. The only difference would be in the advanced tab; if you're strictly using that pc as a backup machine and you don't want it to push any new changes the select receive only but if you use both computers (a laptop and a desktop) then choose send and receive. 

![add folder](images/syncthing/add-folder.png)

![receive](images/syncthing/receive.png)

After you created the folder you'll see it on your Syncthing home screen and it'll always pull for changes any time you edit the directory.

To remove a folder click on the folder name then "edit" and you'll see the remove option. This will only remove it from being synced not the folder on your local machine, you would have to do that yourself. 

## Autostart syncthing

Now I'll teach how to auto start syncthing so you can just set it and forget it. They're multiple ways of doing it but the most effecient way I found, which makes the user owner of syncthing is by running `syncthing --no-browser &` in your startup files. EIther our .xinitrc or in your autostart dir. That's it, one line. This way syncthing starts up in the background without launching your browser every time you boot up. 

And that's it, that's  how you can sync up two machines to be mirrors of each other. You can even sync your git repos without having to pull down changes if you suddenly have to start working on your laptop.
