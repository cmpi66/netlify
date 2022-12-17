---
# type: docs 
title: Create backups with Rsync
date: 2022-12-01T07:00:10-05:00
featured: false
draft: false
description: A basic guide on how to use Rsync.
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["linux", "cli", "backup"]
images: []
---

Rsync is a file syncing command line utility that can sync across many computers, including servers. It has the ability to copy incremental files and it can resume a sync if it was abruptly cut short. You can even use it to update your website by editing your website locally and running an rsync command to send the files to the server. 

Rsync should come installed with most linux systems if not just install it with your package manager `sudo apt install rsync`.

## The only commands you'll need

Rsync is pretty basic to understand it works as a copy command locally: `rsync file file2`. But the power with rsync is with copying over to other machines. Let's try it.

```bash
rsync file user@IP 
```

That copies over `file` to whatever user you specified. It puts it in the users home directory. To specify directory:

```bash
rsync file user@IP:/home/user/test
```

That would put the file in the test dir. 

You can also get verbose messages: 

```bash 
rsync -v file user@IP.
```

Rsync works with domain names as well: 

```bash
rsync file root@mydomain.com
```

Transfer directories: 

```bash
rsync -vr testdir user@IP.
```

The coolest feature is rsync will only sync the changes made to a file, so if your copying entire directories but you only change one file, rsync will *only* copy over that file. 

You can do it like so: 

```bash 
rsync -urv testdir user@IP 
```
All you need is the  `-u` flag which means update.

If you want to create archives and preserve permissions:

```bash
rsync -av testdir user@IP
```


And now the coolest command to update your website locally:

```bash
rsync -urvP --delte-after ~/.local/src/site/ root@mydomain.com:/var/www/mysite/

```
That updates your site every time you make a change to a file. The `-P` command means partial so if the connection drops itll resume right back up. The `--delte-after` command deletes any duplicate files and keeps your live site's files the same as your local copy.


That's it, a quick tutorial on rsync.
