# k8s-cp-utilities: Kubernetes Cloud Provider utilities

Docker image with kubectl and several utilities for operating with different cloud providers.

## History

This image was born when I tried to use images from  ECR repositories (Amazon) into Digital Ocean kubernetes cluster.

ECR credentials expire after several hours so it's neccesary to have a service on kubernetes cluster to renew credentials.

Digital Ocean credentials expire after 7 days so it's necessary to use the doctl utilities to get new credentials an be able to launch kubectl operations on the cluster where the credentials need to be renewed.

## Utilities

- kubectl
- doctl
- awscli

## How to use

- Copy providers-credentials-config.yaml.template to providers-credentials-config.yaml
- Set values for the environment variables on providers-credentials-config.yaml
    Be careful! numeric values between quotes!
- Set variables on kubernetes cluster:
    kubectl apply -f providers-credentials-config.yaml
- Launch job or cron job
