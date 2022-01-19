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
brew install hugo

# Grab code
git clone https://github.com/benoram/oram.co
cd oram.co

# Setup terrform
cd cicd
terraform init # Select the "dev" workspace when prompted
cd -

cd infrastructure
terraform init # Select the "dev" workspace when prompted
cd -

# Setup web project
cd code
npm install

# Run locally
npm run development
hugo serve
// You can view the site at [http://localhost:1313](http://localhost:1313)
```

## Project Folder Layout

### cicd

The [./cicd](./cicd) folder hosts all the Terraform necessary to instantiate our automation pipeline. The templates in this folder deploy AWS CodePipeline for a given repo, and that CodePipeline will be triggered by GitHub commit to build and push updates to infrastructure and code.

> Note:
There is an expectation that the CICD Terraform rarely changes. When it does, you will need to run the terraform scripts locally to update your envionments.

From the command line.

```bash
terraform login
terraform init # select dev or prod as appropriate
terraform validate
terraform plan # manually review the plan
terraform apply 
```

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
