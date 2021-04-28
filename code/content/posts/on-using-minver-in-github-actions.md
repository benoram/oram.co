---
draft: false
date: 2021-04-23T20:21:08-06:00
title: Using Minver to generate a version number in Github Actions
description: 
tags: [.net, github actions]
post_type: "on"
---
MinVer is a tool that you can use to generate a version number that is based on your git repository history.

The tool does require .NET, but there is no requirement that you develop your app in .NET

Within your GitHub Action workflow,  you can run MinVer to generate the version number and store it in an environment variable for later use.

### GitHub checkout and set fetch depth appropriately

```yaml
- uses: actions/checkout@v2
  with:
    fetch-depth: 0
```

### Retrieve version and store in env

```yaml
- name: Set APP_VERSION based on repo w/MinVer
   run: |
    dotnet tool install -g minver-cli -v q
    APP_VERSION=`minver`
    echo "Adding version to GITHUB_ENV: APP_VERSION=$APP_VERSION"
    echo "APP_VERSION=$APP_VERSION" >> $GITHUB_ENV
```

### Example: Reference the variable in later steps

```yaml
- name: Publish artifact to GitHub
  uses: softprops/action-gh-release@v1
  with:
    files: artifacts.zip
    tag_name: ${{ env.APP_VERSION }}
  env:
    GITHUB_TOKEN: ${{ github.token }}```
```

### References

- [MinVer](https://github.com/adamralph/minver)
- [How MinVer works](https://github.com/adamralph/minver#how-it-works)