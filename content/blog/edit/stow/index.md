---
# type: docs 
title: Easily manage your dotfiles with Stow
date: 2022-11-29T18:06:16-05:00
featured: false
draft: false
description: This article will show you how to effectively and lazily manage your dotfiles. 
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["Linux", "dotfiles", "automation"]
images: []
---


Are you having a hard time managing your dotfiles and keeping them synced up with your repositories. Don't worry, in this short article I'll show you how you easyily you can automate it without having to manually push changes to files you edited. 

## Install Stow

First install GNU stow, its a basic program which means it's in most Linux distribution repositories. 

## How it Works

Now the way that stow works, it creates a symlink to any directory you want and it puts the symlink where the directory belongs. For example let's say I have a config file for my terminal in `~/.config/suckless/st` that I have a copy of in my `dotfiles` repo. 

- First `cd dotfiles` then create the st directory `mkdir -pv st`.

- Now `cd st`, that `st` folder is equivalent to your `~` directory. So now we create the same directory structure of our `st` config. 

- `mkdir -pv .config/suckless/st` then you go to your st config and bring it over to `dotfiles/st/.config/suckless/st`

- Now go back until you're in `dotfiles` only and run the command `stow --target=/home/user st` and that's it. What this command is doing is creating a symlink to `st` and using your home directory as the location of the symlinks, this is useful if you keep all your repos in `/home/user/repos/`. If you run it without `--target=/home/user` then the symlink would be in the root of that directory instead of where the config file belongs.   


You'll see a symlink of st in your `/home/user/.config/suckless/st.` Every change you make to that file will automatically happen on the original which is in `dotfiles/st/.config/suckless/st`. 

Obviously using the command to stow only one directoy is inefficent, to stow all directories in your repo except the README:

```bash
stow --target=/home/user/ */

```
And that's how easy it is to manage all your dotfiles.  Here's a sample of my dotfiles:

![repo](images/stow/repo.png "The repo, you can see the folders for all my configs")


![symlinks](images/stow/symlinks.png "All the symlinks it creates")
