---
draft: false
title: KMS Key Rotation
description: 
date: 2021-04-20T20:12:39-06:00
tags: [aws, kms, cmk]
post_type: "on"
---
AWS managed keys are rotated automatically every 3 years. For these keys, there is not a way to manually trigger a key rotation, or change the rotation schedule. These are AWS Managed Keys after all :)

Customer managed keys in KMS have more flexibility. While key rotation is not required, they can be configured automatically rotate every year. In addition, key rotation may be triggered manually, or a rotation can be triggered manually or through API.

To enable manual rotation, make sure that all key references are through an alias. Aliases enable manual key rotation by allowing you to point the alias to a new key at any time.

### References

- [AWS: Rotating customer master keys](https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html)
- [AWS: Using aliases](https://docs.aws.amazon.com/kms/latest/developerguide/kms-alias.html)