---
draft: false
date: 2021-05-07T08:21:00-06:00
title: macOS on AWS EC2
description: 
tags: [aws, macos]
post_type: "on"
---
I had a chance this week to run macOS on AWS EC2 . First impression, it is expensive and boot/reboot times are very slow. In my case I wanted some dev boxes to hand over to an engineer and I didn't want to pull out my credit card. I was able to spin up an EC2 instance for each of the 3 most recent versions of MacOS in less than 30 minutes. 

If you want to use VNC/Screen Sharing, you will need to run the following two commands to set a password and enable remote management.

```bash
# Set pasword
sudo passwd ec2-user

# Enable VNC access
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart \
-activate -configure -access -on \
-restart -agent -privs -all

# Fixup the disk to make the full EBS volume available
PDISK=$(diskutil list physical external | head -n1 | cut -d" " -f1)
APFSCONT=$(diskutil list physical external | grep "Apple_APFS" | tr -s " " | cut -d" " -f8)
yes | sudo diskutil repairDisk $PDISK

sudo diskutil apfs resizeContainer $APFSCONT 0
```

Overall [MacStadium](https://www.macstadium.com/) is much more cost-effective, they know Macs and they have M1. But if you want something running within AWS, your VPC, or in regions where MacStadium doesn't yet exist and you are ok with Intel, Mac on EC2 works just fine.

## References
- [Aamzon EC2 Mac instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-mac-instances.html) 
- [MacStadium](https://www.macstadium.com/)