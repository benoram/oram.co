---
draft: false
date: 2021-04-25T20:46:24-06:00
title: ASP.NET 5.0 and the docker images published by Microsoft
description: 
tags: [docker, asp.net core]
post_type: "on"
---

Where possible, leverage the Alpine docker image for ASP.NET Code. Out of the box, the image is more secure than the default Debian buster image, and the Alpine images are a bit smaller.

```bash
docker pull mcr.microsoft.com/dotnet/aspnet:5.0-alpine
```