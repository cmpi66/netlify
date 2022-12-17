---
# type: docs 
title: Get a website right now
date: 2022-11-29T17:46:05-05:00
featured: false
draft: false
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["server", "Linux"]
images: []
---

In this guide I'll show you how easy it is to get a website up and running in 10 minutes or less.

<!--more-->

They're four things you need to set up a site: a domain name, a server, connecting that domain name to your server and finally installing a webserver and enabling HTTPS. Don't it worry it might sound like a lot but we'll get this done in 15 mins or less. 

## get a domain

First off a domain name is just name connected to an ip address (the server that we'll create soon) so it'll be easier for humans to remember instead of a string of numbers. Domain names are also relatively cheap, .com's are about 12$ a year. Although they're rarer to find in ccertain names since they were the first to exist.  

They're many domain providers and I'm not partial to any but this time we'll be going with name cheap since they have [99 cent domains](https://www.namecheap.com/promos/99-cent-domain-names/?utm_source=CJ&utm_medium=Affiliate&utm_campaign=100268310&ref=cj&affnetwork=cj&cjevent=47ed45346c4811ed820e054e0a82b824). 

![adding to cart](images/webserver/adding-to-cart.png)

Go ahead and type in the domain you would like and if its available add it to your cart and checkout. Don't worry about the extras they're trying to push like ssl, we'll get that for free later. 

![checkout](images/webserver/checkingout.png)

Now that you've checked out you can go to your domain and update its dns records. We'll get to that later. Let's get our server. 

## Get a server

A virtual private server (VPS) is just a cheap way for anyone to host a service without having any on-premises machine. A vps usually runs $5 a month but sometimes they can be more. You can decide how powerful you want your VPS to be, but $5 is good enough to start with. With that single vps you can host a bunch of differnet services.

Let's go to [vultr.com](https://vultr.com) to get our vps. Go ahead and create an account. Once your logged in go to "deploy a new server". Choose cloud compute and regular intel performance. Choose the are closets to you physically for best performance and create an unbuntu 22.04 lts image. Make sure you have the ipv6 option enabled. Enter the name of your server and deploy. That's  it! Now we'll have to wait a few minutes so it could do it's magic and we'll be able to connect to it. 

![choosing](images/webserver/choosing.png)

![ubuntu](images/webserver/ubuntu.png)

![ipv6](images/webserver/ipv6.png)

### connect domain and server

Once your server deploys and you can see its IP we can connect it to the domain server. Let's do that right now. Log in to namecheap.com and go to your domain click manage, then use custom dns, now let's add vultrs name servers so we can manage our DNS records directly from vultr. Make sure it looks like this:   

![ipv6](images/webserver/custom-dns.png)

Now we can go to vultr and add our domain, go to the dns tab and add your domain. Then within that domain we can add the IP address of the server we created, like so: 

![dns](images/webserver/dns.png)

Finally we're ready for our website. 

## Setting up webserver

Let's log in to our server with `ssh root@domain`. Once your logged in `apt update && apt upgrade -y` to update all packages. Once that's done log back out and let's create a pair of SSH keys so we won't have to use passwords. On your local machine run `ssh-keygen -t rsa -b 2048`. What this command is doing: the `-t` flag is the type of key, `-b` flag is bits aka how big it will be.

Once that's  done you can run `ssh-copy-id root@domain` put in your password for the last time and now you can log in password less. Make sure you back up your key. Now to make our server even more secure let's disable password logins. Run `nano /etc/ssh/sshd_config`, turn passwordauthentication=yes to "=no" and make sure the AuthorizedKeysFile is uncommented and pointing to the correct file. Now save and quit the file and run `systemctl restart sshd.service`. That's it.   

![harden](images/webserver/ssh-harden.png)

With that out of the way let's install our packages for our website. Run `apt install nginx`. This is the webserver once its finished let's create our config file `nano /etc/nginx/sites-available/yoursite`, you can name it whatever you want. But it has to be in the `/etc/nginx/sites-available` directory. Now put this into your file:
```shell
server {
        listen 80 ;
        listen [::]:80 ;
        server_name example.org ;
        root /var/www/mysite ;
        index index.html index.htm index.nginx-debian.html ;
        location / {
                try_files $uri $uri/ =404 ;
        }
}


```

### What these settings mean

- Listen 80 means that's  the port nginx will use to host your site

- server_name is the name of your site

- root /var/www/mysite is where all the files to your site live

- index is what file will be displayed when someone goes to yoursite.com, it'll most likely be index.html 

- location is telling the site how to look up files else it throws up a 404 error 

Now edit the two lines: server_name and root /var/www/mysite. Make sure you put your domain name for server name and create the directory for your site in /var/www/. This is where all the files for your site live.  

Create an index.html in /var/www/mysite and put in the following:

```html
<!DOCTYPE html>
 <h1>My new website!</h1>
 <p>This is my website. </p>
 <p>Now my website is live.</p> 

```
Save your file and link it to nginx's sites-enabled dir: `ln -s /etc/nginx/sites-available/yoursite /etc/nginx/sites-enabled`

Then reload nginx, `systemctl reload nginx` and now visit your site and you'll see the text your wrote.

![live](images/webserver/live.png)

Sometimes vultr's firewall will block ports 80 and 443 so let's enable them: `ufw allow 80 && ufw allow 443`.

Now you have a website! 

## HTTPS

The final piece adding enrypted HTTPS. This is easy just install this package `apt install python3-certbot-nginx`. Then run `certbot --nginx` and press enter for the defaults, itll go out and get you free ssl certificates. Now go to your site and you'll see you have an enrypted connection. How easy was that. The certs only last 3 months so let's create a cronjob to auto renew: `crontab -e` choose your editor of choice and put this new line `0 0 1 * * certbot --nginx renew`. What this line is doing is running certbot's renew command every month automatically so we won't have to. And that's  it you have a fully functional and HTTPS encrypted website.



