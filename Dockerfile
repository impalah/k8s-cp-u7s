FROM alpine:3.7

LABEL version=1.0
LABEL maintainer="impalah@gmail.com"

ENV K8S_CLUSTER_NAME nada

ENV AWS_ACCOUNT nada
ENV AWS_ACCESS_KEY_ID nada
ENV AWS_SECRET_ACCESS_KEY nada
ENV AWS_DEFAULT_REGION nada
ENV AWS_DEFAULT_MAIL nada@mail.com

ENV DO_ACCESS_TOKEN nada

RUN apk update
RUN apk add --no-cache --virtual .build-deps
RUN apk add bash
RUN apk add make && apk add curl && apk add openssh
RUN apk add git
RUN apk add nodejs
RUN apk add yarn

RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# doctl
ENV DOCTL_VERSION=1.19.0
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

WORKDIR /app
RUN curl -L https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz  | tar xz

# kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

# Move doctl to the work folders (/root/.kube/doctl)
RUN mkdir /root/.kube
RUN cp ./doctl /usr/local/bin/doctl
RUN cp ./doctl /root/.kube/doctl

# aws cli
RUN apk -Uuv add groff less python py-pip
RUN pip install awscli
RUN apk --purge -v del py-pip
RUN rm /var/cache/apk/*

# ENTRYPOINT ["./doctl"]
ENTRYPOINT ["echo", "Kubernetes Cloud Provider utilities"]
