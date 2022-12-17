---
# type: docs 
title: Next Cloud
date: 2022-11-30T13:24:02-05:00
featured: false
draft: true
description: Build your own cloud with Nextcloud and Ubuntu server.
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["Linux", "Nextcloud", "Backup", "self hosted"]
images: []
---


In this guide you'll learn how to create your own cloud on an Ubuntu server with Nextcloud. Nextcloud is a free and open source google drive alternative. Its highly extensible and custmoizable, it can be used on your phone, tablets and PCs.

## Create an ubuntu server

We'll be creating an Ubuntu 22.04 server over on Vultr, but you can spin this up in any enviorment you want, virtual machine, or your own homelab server. If you're  following along and setting it up at vultr , then check out my breife [get a website]() guide. There's  a section in there dedicated to deploying a server with Vultr, it only takes 2-4 minutes. 


## updating and adding user

Connect to the server with ssh `ssh root@IP`. Update the server, `apt udate && apt upgrade -y`.

Create a local user: `adduser USERNAME`

Add the user to the sudo group: `usermod -aG sudo USERNAME`

Switch to the user: `su USERNAME`

## Installing and configuring database

Download the nextcloud zip: `wget https://download.nextcloud.com/server/releases/latest.zip`

Download the database: `sudo apt install mariadb-server -y`

Secure the database: `sudo mysql_secure_installation` It'll prompt you for a root password, just press enter, that root user is the database user not your Linux server user. Press `n` for the first question, then set up a secure password for the database root user, press `Y` for the rest of the prompts.

Now we need to set up our database with nextcloud:

```
sudo mariadb
```
Now we're in mariadb, create the database:

```mysql
CREATE DATABASE nextcloud;
```

```mysql
GRANT ALL ON nextcloud.* TO 'nextcloud'@'localhost' IDENTIFIED BY 'password';
```
Change 'password' to your own password.

```mysql
FLUSH PRIVILEGES;
EXIT;
```
## Creating the webserver 

Now we'll create the webserver, Install the dependencies:

```
sudo apt install nginx python3-certbot-nginx php php-fpm php-bcmath php-bz2 php-intl php-curl php-xml php-gd php-mysql php-mbstring php-zip
```

If you used vultr for your server then enable ports 80 and 443 on the firewall:

```
sudo ufw allow 80 

sudo ufw allow 443
```

Get an https cert for your subdomain:


```
sudo certbot certonly --nginx -d nextcloud.example.org
```

Add the config to /etc/nginx/sites-available/nextcloud, change the domains to your domain:

```
upstream php-handler {
    server unix:/var/run/php/php7.4-fpm.sock;
    server 127.0.0.1:9000;
}
map $arg_v $asset_immutable {
    "" "";
    default "immutable";
}
server {
    listen 80;
    listen [::]:80;
    server_name nextcloud.example.org ;
    return 301 https://$server_name$request_uri;
}
server {
    listen 443      ssl http2;
    listen [::]:443 ssl http2;
    server_name nextcloud.example.org ;
    root /var/www/nextcloud;
    ssl_certificate     /etc/letsencrypt/live/nextcloud.example.org/fullchain.pem ;
    ssl_certificate_key /etc/letsencrypt/live/nextcloud.example.org/privkey.pem ;
    client_max_body_size 512M;
    client_body_timeout 300s;
    fastcgi_buffers 64 4K;
    gzip on;
    gzip_vary on;
    gzip_comp_level 4;
    gzip_min_length 256;
    gzip_proxied expired no-cache no-store private no_last_modified no_etag auth;
    gzip_types application/atom+xml application/javascript application/json application/ld+json application/manifest+json application/rss+xml application/vnd.geo+json application/vnd.ms-fontobject application/wasm application/x-font-ttf application/x-web-app-manifest+json application/xhtml+xml application/xml font/opentype image/bmp image/svg+xml image/x-icon text/cache-manifest text/css text/plain text/vcard text/vnd.rim.location.xloc text/vtt text/x-component text/x-cross-domain-policy;
    client_body_buffer_size 512k;
    add_header Referrer-Policy                      "no-referrer"   always;
    add_header X-Content-Type-Options               "nosniff"       always;
    add_header X-Download-Options                   "noopen"        always;
    add_header X-Frame-Options                      "SAMEORIGIN"    always;
    add_header X-Permitted-Cross-Domain-Policies    "none"          always;
    add_header X-Robots-Tag                         "none"          always;
    add_header X-XSS-Protection                     "1; mode=block" always;
    fastcgi_hide_header X-Powered-By;
    index index.php index.html /index.php$request_uri;
    location = / {
        if ( $http_user_agent ~ ^DavClnt ) {
            return 302 /remote.php/webdav/$is_args$args;
        }
    }
    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }
    location ^~ /.well-known {
        location = /.well-known/carddav { return 301 /remote.php/dav/; }
        location = /.well-known/caldav  { return 301 /remote.php/dav/; }
        location /.well-known/acme-challenge    { try_files $uri $uri/ =404; }
        location /.well-known/pki-validation    { try_files $uri $uri/ =404; }
        return 301 /index.php$request_uri;
    }
    location ~ ^/(?:build|tests|config|lib|3rdparty|templates|data)(?:$|/)  { return 404; }
    location ~ ^/(?:\.|autotest|occ|issue|indie|db_|console)                { return 404; }
    location ~ \.php(?:$|/) {
        # Required for legacy support
        rewrite ^/(?!index|remote|public|cron|core\/ajax\/update|status|ocs\/v[12]|updater\/.+|oc[ms]-provider\/.+|.+\/richdocumentscode\/proxy) /index.php$request_uri;
        fastcgi_split_path_info ^(.+?\.php)(/.*)$;
        set $path_info $fastcgi_path_info;
        try_files $fastcgi_script_name =404;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $path_info;
        fastcgi_param HTTPS on;
        fastcgi_param modHeadersAvailable true;
        fastcgi_param front_controller_active true;
        fastcgi_pass php-handler;
        fastcgi_intercept_errors on;
        fastcgi_request_buffering off;
        fastcgi_max_temp_file_size 0;
    }
    location ~ \.(?:css|js|svg|gif|png|jpg|ico|wasm|tflite|map)$ {
        try_files $uri /index.php$request_uri;
        add_header Cache-Control "public, max-age=15778463, $asset_immutable";
        access_log off;     # Optional: Don't log access to assets
        location ~ \.wasm$ {
            default_type application/wasm;
        }
    }
    location ~ \.woff2?$ {
        try_files $uri /index.php$request_uri;
        expires 7d;
        access_log off;
    }
    location /remote {
        return 301 /remote.php$request_uri;
    }
    location / {
        try_files $uri $uri/ /index.php$request_uri;
    }
}

```
Now link the website: 

```
sudo ln -s /etc/nginx/sites-available/nextcloud /etc/nginx/sites-enabled
```
Unzip the nextcloud zip we downloaded earlier move it to the www dir and change its permissions:

```
unzip latest.zip 
sudo mv nextcloud /var/www/
chown -R www-data:www-data /var/www/nextcloud
chmod -R 755 /var/www/nextcloud

```
