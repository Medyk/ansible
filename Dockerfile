FROM debian:bullseye

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
    apt-get -y install curl wget nano && \
    apt-get -y clean && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip && \
    pip3 install --upgrade virtualenv && \
    pip3 install pywinrm[kerberos] && \
    pip3 install pywinrm && \
    pip3 install jmespath && \
    pip3 install requests && \
    pip3 install hvac && \
    python3 -m pip install ansible && \
    ansible-galaxy collection install community.general && \
    ansible-galaxy collection install community.hashi_vault
