---
draft: false
date: 2021-04-22T20:20:51-06:00
title: AWS Generated Passwords for Windows
description: 
tags: [aws, ec2, windows]
post_type: "on"
---

When launching a Windows instance via an AWS AMI, a password is automatically generated, and encrypted using the keypair associated with the instance. 

As a best practice, this generated password should be changed. Many folks choose to create a new local administrator account with a unique username, and additionally many teams choose to join the instance to a domain, and let the domain handle authentication. 

Finally, starting with Windows Server 2016, AMIs maintained by AWS are configured to allow generated passwords to expire.

### References

- [Set the password for a Windows instance](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ec2-windows-passwords.html)