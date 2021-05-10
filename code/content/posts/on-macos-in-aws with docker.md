---
draft: false
date: 2021-05-09T09:55:00-06:00
title: macOS on AWS EC2 - Docker with private repos
description: 
tags: [aws, macos, docker]
post_type: "on"
---
I ran into an issue with my EC2 macOS setup where running ```docker login``` from SSH resulted in the following error

```
Error saving credentials: error storing credentials - err: exit status 1, out: `User interaction is not allowed.`
```

Working around the issue involved running the following in my SSH session before running ```docker login```

```bash
security unlock-keychain ${HOME}/Library/Keychains/login.keychain-db 
```

In subsequent sessions you may see an ```unknown: Authentication is required``` error. To avoid, run the unlock-keychain command again.
