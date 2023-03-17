FROM ubuntu:latest

ARG TERRAFORM_VERSION=1.1.5
ARG PACKER_VERSION=1.7.7
ARG NODE_VERSION=16.x

# Install required packages
RUN apt-get update && apt-get install -y \
    unzip \
    wget \
    curl \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv terraform /usr/local/bin/

# Install Packer
RUN wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
    && unzip packer_${PACKER_VERSION}_linux_amd64.zip \
    && mv packer /usr/local/bin/

# Install Node.js and AWS Amplify CLI
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} | bash - \
    && apt-get install -y nodejs \
    && npm install -g @aws-amplify/cli \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /src

# Set the entrypoint
ENTRYPOINT ["/bin/bash"]
