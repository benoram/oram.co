---
draft: false
date: 2021-04-21T20:02:39-06:00
title: Secrets, local development and ASP.NET Core
post_type: "on"
description: 
tags: [asp.net core]

---
Storing secrets in source control is something to avoid. Secrets stored in git can easily be inadvertently shared though a fork or push to a public origin, and they are easily found in-bulk by anyone with read access to the repo.

For .NET developers that need secrets on their local machine, leverage ```dotnet user-secrets``` to store secrets that can be easily retrieved through configuration. For Mac users, secrets are stored in ```~/.microsoft/usersecrets```

### Prereq

From your project's source directory, run this command. It only needs to be run once.

```bash
dotnet user-secrets init
```

### Set a secret from command-line/terminal

From your project's source directory

```bash
dotnet user-secrets set "db:password" "VerySecurePassword!0!"
```

### Retrieve secret in code

```csharp
var password = Configuration["db:password"];
```

### References

- [Safe storage of app secrets](https://docs.microsoft.com/en-us/aspnet/core/security/app-secrets?view=aspnetcore-5.0)
- [AWS git-secrets](https://github.com/awslabs/git-secrets)