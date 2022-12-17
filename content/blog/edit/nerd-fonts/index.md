---
# type: docs 
title: Nerd Fonts
date: 2022-11-29T18:31:35-05:00
featured: false
draft: false
description: How to get icons in your terminal.
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["Linux", "Nerd-Fonts"]
images: []
---


This is a short and sweet article on how to get nerd fonts and icons on Linux. 

First there are two places where you should put your fonts in: 

`/usr/share/fonts/`

`~/.local/share/fonts/`

I recommend you put all your fonts in the local user directory. 

## Downloading the fonts

Now some distribution repos will contain the nerd fonts and if they do then you can stop reading this article here. But for those of you who don't have them in your distribution's repos, you can go [here](https://github.com/ryanoasis/nerd-fonts) and go to the patched front directory and download what ever font you want. 

After you've downloaded them, add them to your `~/.local/share/fonts/` directory and run the command `fc-cache -f -v` to regenerate all your fonts. And now you have glyphs and icons in your terminal. It's that easy.

![icons](images/icons.png)
