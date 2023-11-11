FROM debian:bullseye

ARG ANSIBLE_VERSION=6.6.0

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install locales && \
    sed -i -e "s/# en_US.UTF-8.*/en_US.UTF-8 UTF-8/" /etc/locale.gen && \
    dpkg-reconfigure -f noninteractive locales && \
    update-locale LANG=en_US.UTF-8

RUN apt-get -y install gcc libkrb5-dev python3 python3-dev && \
    apt-get -y install python3-pip && \
    apt-get -y install curl wget nano sshpass

RUN python3 -m pip install --prefix /usr/local --upgrade pip setuptools wheel && \
    python3 -m pip install --prefix /usr/local --upgrade virtualenv && \
    python3 -m pip install --prefix /usr/local --upgrade pywinrm[kerberos] && \
    python3 -m pip install --prefix /usr/local --upgrade pywinrm && \
    python3 -m pip install --prefix /usr/local --upgrade jmespath && \
    python3 -m pip install --prefix /usr/local --upgrade requests && \
    python3 -m pip install --prefix /usr/local --upgrade hvac && \
    python3 -m pip install --prefix /usr/local --upgrade ansible==${ANSIBLE_VERSION} && \
    ansible-galaxy collection install community.general && \
    ansible-galaxy collection install community.hashi_vault

RUN apt-get -y remove python3-pip python3-setuptools python3-wheel && \
    apt-get -y clean && rm -rf /var/lib/apt/lists/*
