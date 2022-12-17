---
# type: docs 
title: Gentoo Emerge tutorial
date: 2022-12-13T07:00:44-05:00
featured: false
description: A tutorial on the gentoo emerge command
draft: false
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["Gentoo", "Linux"]
images: []
---

If you decided to install [gentoo](../edit/gentoo/index.md) heres a small guide on the emerge command.

## install packages

`emerge tmux` This installs the package called "tmux"

`emerge --ask tmux` This asks you before installing "tmux"

`emerge --ask --autounmask` Sometimes packages will be masked by, keywords, use flags and licenses, this outputs what should be written adn to what location. 

## cleaning the system

`emerge --clean` Cleans up the system of the old packages, not the newest verisons, it keeps the most recently **installed** version even if it happens to be an older package

`emerge --depclean` Running this by itslef removes any packages that aren't being used by other packages. 

`emerge --depclean tmux` This is proffered way to remove a package from your system.

`emerge --prune` Removes all but the newest version of all packages.

## searching for packages

`emerge --search tmux` This searches for packages with "tmux" in its name. It's not case sensitive.

`emerge --searchdesc office` to search by descriptions 

## updating

`emerge --sync` This is the equivalent to `apt update` except its through rsync and should only be run once before updating.

`emerge -uDU --keep-going --with-bdeps=y @world` This updates all your packages including dependencies.
