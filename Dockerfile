# Base Centos:latest image
FROM centos

# Install required packages
RUN yum update -y && yum install -y yum-utils
RUN yum groupinstall -y development

# Install python3.6
RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
RUN yum install -y \ 
    python36u \
    python36u-pip \ 
    python36u-devel \
    vim

# Get baselines project folder to local
RUN git clone https://github.com/openai/baselines.git

# Install baseline requirements
COPY ./python_requirements.txt /
RUN python3.6 -m pip install --upgrade --no-cache-dir -r python_requirements.txt

# Install baselines
WORKDIR /baselines
RUN python3.6 -m pip install -e .

RUN mv /baselines/baselines/ /usr/lib/python3.6/site-packages/
WORKDIR /
