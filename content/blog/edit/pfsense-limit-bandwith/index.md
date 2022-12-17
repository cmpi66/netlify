---
# type: docs 
title: How to Limit Bandwith per IP in Pfsense 
date: 2022-12-14T06:01:42-05:00
featured: false
description: Control bandwidth on Pfsense. 
draft: false
comment: true
toc: true
reward: true
pinned: false
carousel: false
categories: []
keywords: []
tags: ["Pfsense","networking","firewall"]
images: []
---

Let's learn how to limit bandwidth per IP in our Pfsense set up. 

Go to your Pfsense portal and under firewall go to traffic shaper and go to the limiters section.

![traffic shaper](images/pfsense-traffic/traffic-shaper.png)

Click add new limiter and customize it like so:

![30mbin](images/pfsense-traffic/30mbin.png)

This is an example if you wanted to create a limit of 30mb down and 10mb up. The only settings you need to tweak are the top ones leave eveything else as default.

![10mbout](images/pfsense-traffic/10mbout.png)

NOw go to firewall, rules, lan and add a rule at the top of the list. Make sure protocol selected is **Any** and under source choose **single host or alias**. And put the IP you want to limit or create an alias and put a list of IPS in the alias and use the alias's name.

![firewall rule](images/pfsense-traffic/rule.png)

Click the gear icon to display advanced and scroll until the very bottom to the In / out Pipe. Put your 10mbout in the **first box** and the 30mbin into the **second box** .

![in out](images/pfsense-traffic/rule.png)

And that's it now you have full control of the bandwith of any IP you want. Its that easy. 
