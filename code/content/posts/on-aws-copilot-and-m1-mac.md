---
draft: false
date: 2021-05-16T14:32:00-06:00
title: AWS Copilot and M1 Mac
description: 
tags: [aws, macos, docker]
post_type: "on"
---
AWS Copilot currently doesn't have support for leveraging ```docker buildx``` to allow for multi-architecture docker builds. So the arm64 images created on your M1 Mac with Apple Silicon will not work on AWS Fargate which is based on amd64 today. The error I was seeing in the CloudWatch logs for my load balanced web services was...

```
standard_init_linux.go:219: exec user process caused: exec format error
```

As a workaround, specify an arm64 version/tag of your `"from"` image in your Dockerfile. While this won't create a multi-architecture image, it will force the creation of an images that will work with AWS Fargate.
An example is below for NGINX.

```dockerfile
FROM amd64/nginx:alpine
EXPOSE 80
COPY . /usr/share/nginx/html
``` 