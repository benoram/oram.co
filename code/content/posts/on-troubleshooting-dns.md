---
draft: false
date: 2021-07-30T06:00:00-06:00
title: Troubleshooting DNS with dig
description: 
tags: [aws, networking]
post_type: "on"
---
The [dig](https://github.com/tldr-pages/tldr/blob/main/pages/common/dig.md) command is incredibly useful for testing DNS. I use this all the time from Mac and Linux. Windows users, `nslookup` may provide similar features, but you can always run [Linux with WSL](https://www.youtube.com/watch?v=A0eqZujVfYU)

### Retrieve nameservers for domain

```bash
dig NS oram.co
```

### And the address(es) for a particular server

```bash
dig oram.co
```

### Force the resolution through Google DNS

```bash
dig oram.co @8.8.8.8
```

### Pretent do be from somewhere else

Since Google DNS supports Client Subnet/EDNS
we can pretend we are from somewhere else in the world. Let's try Italy    

```bash
dig oram.co +subnet=159.122.168.0/24 @8.8.8.8
```

### Reverse DNS

These PTR records don't always exist, but sometimes provide useful information
```bash
> dig -x 99.86.162.73

...
Response: "server-99-86-162-73.mxp64.r.cloudfront.net"
...
```

mxp64 in the record gives some confirmation that the IPs returned [are from CloudFront Milan](https://www.feitsui.com/en/article/3)

### References

- [Dig TLDR](https://github.com/tldr-pages/tldr/blob/main/pages/common/dig.md)
- [AWS CloudFront CDN Edge Locations](https://www.feitsui.com/en/article/3)
- [Locations and IP address ranges of CloudFront edge servers](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/LocationsOfEdgeServers.html)
- [CloudFront IP List](https://d7uri8nf7uskq.cloudfront.net/tools/list-cloudfront-ips)