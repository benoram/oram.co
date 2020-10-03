# Oram.co website

## Plan

Vue and Tailwind based website, hosted on AWS. IaC with Terraform, CICD with CodePipeline.

Site contents - Simple about (home), links (navbar) and resume. Private pages for build status and links to various systems and tools needed for daily work.

## Development Setup


```bash
# Install dev tools
brew cask install visual-studio-code
brew install node
brew install terraform

# Grab code
git clone https://github.com/benoram/oram.co
cd oram.co

# Setup terrform
cd cicd
terraform init # Select the "dev" workspace when prompted
cd -

cd automation
terraform init # Select the "dev" workspace when prompted
cd -

# Setup web project
cd code/web
npm install

# Run locally
npm run serve
// You can view the site at [http://localhost:8080](http://localhost:8080)
```

## Project Folder Layout

### cicd

The [./cicd](./cicd) folder hosts all the Terraform necessary to instantiate our automation pipeline. The templates in this folder deploy AWS CodePipeline for a given repo, and that CodePipeline will be triggered by GitHub commit to build and push updates to infrastructure and code.

> Note:
There is an expectation that the CICD Terraform rarely changes. When it does, you may need to manually disable CodePipeline so you can deploy the CICD update before build automation starts and potentially conflicts.

All deployments of CICD should be done manually using the following steps.

1. Disable CodePipeline by manually deactivating the Webhook trigger using the AWS CLI or Console.
2. Commit and push (dev branch) or merge (Main branch)
3. In the Terraform Cloud Console
    1. Queue Plan
    2. Evaluate plan
    3. If approprate, Apply plan
4. Re-enable the webhook for CodePipeline and manually start a "Release Change"

![CICD](./docs/diagrams/cicd.png)

## code/web

The [./code/web](./code/web) folder contains the website code and content.

## deploy

The [./deploy](./deploy) folder contains the CodeBuild buildspec.yaml that handles our code deployments.

## infrastructure

The [./infrastructure](./infrastructure) folder contains the CodeBuild buildspec.yaml that handles our IaC deploymentments for website infrastructure with Terraform.

## Services Used and Dependencies

[Terraform Cloud](https://app.terraform.io) - Used to host Terraform state; Build and apply Terraform plans.
[VUE.JS](https://vuejs.org/)
[NPM](https://www.npmjs.com/)
[tailwindcss](https://tailwindcss.com/)
