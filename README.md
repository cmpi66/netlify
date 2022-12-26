
# [Munozpi.com](https://munozpi.com)


[![Netlify Status](https://api.netlify.com/api/v1/badges/7d00605d-360e-40b0-9125-d32fbb1a817c/deploy-status)](https://app.netlify.com/sites/elaborate-sprite-b67a31/deploys)

This is a website I created to document the things I’ve learned and done over the past year (2022) related to IT. As of Dec. 2022, the bulk of the content centers around Linux and Raspberry Pi (also Linux).

Below are a few evergreen pieces I wrote that I think people will find useful. Although, the Raspberry Pi one might be hard to do right now.

The website doesn’t reflect everything I’ve learned (it’ll get filled up over time) but it does outline a decent portion.

In the future, there’ll be more hacking, cybersecurity, networking, firewalls, home lab, scripting and automation tutorials.


## How it works

You can go [here](https://www.munozpi.com/blog/about-this-site/) to see how I built this site.

I deploy my website to [Netlify](https://netlify.com), so a netlify.toml handles the automatic deployment every time I push to the `main branch`. I keep the content in a separate private repo and load it up with a [git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules).

A Makefile stores all the commands to running and deploying the site. That way I won’t have to remember countless commands. The Makefile updates Hugo, the theme and installs any dependencies.

## A Few Useful Articles

- [Get a website up and running in 20 mins or less](https://www.munozpi.com/completed-projects/webserver/)

- [Use a Raspberry Pi as a home server with docker containers](https://www.munozpi.com/completed-projects/rasperrypi-home-server/#post-content-body)

- [Use stow to manage your dot files](https://www.munozpi.com/blog/stow/#post-content-body)

- [A brief overview on Gentoo Linux](https://www.munozpi.com/blog/gentoo/#post-content-body)

- [The Linux file structure](https://www.munozpi.com/blog/linux-file-structure/#post-content-body)

- [A brief Ansible tutorial](https://www.munozpi.com/blog/ansible/)
