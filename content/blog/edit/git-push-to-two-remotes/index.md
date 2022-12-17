---
# type: docs 
title: Push a git repo to two or more remotes
date: 2022-12-11T07:59:37-05:00
featured: false
draft: false
description: Easily push a git repo to as many remotes as you want.
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["git", "bash"]
images: []
---

First create the repo locally `git init --initial-branch=main newrepo`.

Then go to [github](https://github.com) and create that same repo *without* a README. Now add the remote url to your local repo `git remote add origin git@github.com:YOURNAME/newrepo.git`

Now go to [gitlab](https://gitlab.com) and do the same, create the repo without a README and copy the url. This time name the remote something else: `git remote add lab git@gitlab.com:YOURNAME/newrepo.git`

And now here's to command to push to all:

```bash
git add . && git commit -m 'autopush' && git remote | xargs -L1 git push --all

```
The part that pushes to all remotes is the `xargs` bit, the previous part is just a faster way to do `git add` and `git commit`. 

And that's it, now you can push to as many remotes as you want. Now you'll always have a backup of your repo just in case. Here's a sample where I have three, github, gitlab, and my own git server:

![all remotes](images/all-remotes.png)
