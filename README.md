# blog-breaking-apart-monolith-cloudformation-stacks-with-cfhighlander
Breaking apart monolith Cloudformation stacks with CfHighlander

[Blog Post](#)

## Setup

Install cfhighlander gem

```bash
gem install cfhighlander
```

We will also use the aws cli to deploy your cloudformation stacks

```bash
brew install aws-cli
```

Clone the repo

```bash
git clone git@github.com:Guslington/blog-breaking-apart-monolith-cloudformation-stacks-with-cfhighlander.git
```

## Deploying the infrastructure stack

Compile and validate the templates

```bash
cd infrastructure
cfcompile --validate
```

Publish the rendered cloudformation to s3, it will return a generated s3 bucket location you can then use to launch the stack

```bash
cfpublish infra

....

Use following template url to update the stack

https://${AWS_AccountId}.${AWS_Region}.cfhighlander.templates.s3.amazonaws.com/published-templates/infra/latest/infra.compiled.yaml
```

We need to grab the latest amazon AMI id's for your region to pass as parameters for the stack

bastionAmi - [Amazon Linux 2018.03](https://aws.amazon.com/amazon-linux-ami/)
ecsAmi - [Amazon ECS Optimised](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html)



launch the stack with the aws cli

```bash
aws cloudformation create-stack \
  --stack-name infra \
  --template-url https://${AWS_AccountId}.${AWS_Region}.cfhighlander.templates.s3.amazonaws.com/published-templates/infra/latest/infra.compiled.yaml \
  --parameters ParameterKey=ecsAmi,ParameterValue=ami-02c73ee1100ce3e7a ParameterKey=bastionAmi,ParameterValue=ami-09b42976632b27e9b \
  --capabilities CAPABILITY_IAM
```

Once stack is created successfully we can the create the ECS services stacks

## Deploying the Web ECS Service stack

In the [api-service](api-service) directory we have our api source code, the dockerfile and the cfhighlander config.
At this stage you could build and push the docker image to your own repo, but i have done this already so
you can skip that step and go straight to deploying.

Compile and validate the templates

```bash
cd api-service
cfcompile --validate
```

Publish the rendered cloudformation to s3, it will return a generated s3 bucket location you can then use to launch the stack

```bash
cfpublish api

....

Use following template url to update the stack

https://${AWS_AccountId}.${AWS_Region}.cfhighlander.templates.s3.amazonaws.com/published-templates/api/latest/api.compiled.yaml
```

launch the stack with the aws cli

```bash
aws cloudformation create-stack \
  --stack-name infra \
  --template-url https://${AWS_AccountId}.${AWS_Region}.cfhighlander.templates.s3.amazonaws.com/published-templates/api/latest/api.compiled.yaml \
  --parameters ParameterKey=ApiTag,ParameterValue=latest \
  --capabilities CAPABILITY_IAM
```

## Deploying the Api ECS Service stack

In the [web-service](web-service) directory we have the same layout as the api directory.
So you can repeat this for each of your ECS services weather you have 2 or 200 services.

Compile and validate the templates

```bash
cd web-service
cfcompile --validate
```

Publish the rendered cloudformation to s3, it will return a generated s3 bucket location you can then use to launch the stack

```bash
cfpublish web

....

Use following template url to update the stack

https://${AWS_AccountId}.${AWS_Region}.cfhighlander.templates.s3.amazonaws.com/published-templates/web/latest/web.compiled.yaml
```

launch the stack with the aws cli

```bash
aws cloudformation create-stack \
  --stack-name infra \
  --template-url https://${AWS_AccountId}.${AWS_Region}.cfhighlander.templates.s3.amazonaws.com/published-templates/web/latest/web.compiled.yaml \
  --parameters ParameterKey=WebTag,ParameterValue=latest \
  --capabilities CAPABILITY_IAM
```
