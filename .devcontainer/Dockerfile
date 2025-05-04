# An example Dockerfile for Ruby on Rails development with asdf

### ARGs
ARG DEBIAN_FRONTEND=noninteractive
ARG VARIANT=bullseye

### FROM
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

ARG DEBIAN_FRONTEND

### ENVs
ENV APP_PATH /app
ENV DEBIAN_FRONTEND ${DEBIAN_FRONTEND}
ENV AWS_PROFILE deploy

### Install all dependencies you need for your project here
RUN mkdir -p "$APP_PATH" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  gnupg software-properties-common \
  unzip curl

RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
  gpg --dearmor | \
  tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null && \ 
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  tee /etc/apt/sources.list.d/hashicorp.list

RUN apt-get update && \
  apt-get install terraform

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
  unzip awscliv2.zip && \
  ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update  

### Set the workdir
WORKDIR "$APP_PATH"

SHELL ["/bin/bash", "-lc"]

# Change ownership of ASDF installations
RUN chown -R vscode:vscode /usr/local/aws-cli

USER vscode