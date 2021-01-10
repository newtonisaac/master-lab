FROM docker:dind

RUN apk add --no-cache btrfs-progs e2fsprogs \
		e2fsprogs-extra iptables xfsprogs \
		xz py-pip openssh rsyslog git \
        bash curl coreutils nano

RUN rm -rf /root/.cache \
    && mkdir -p /root/.ssh/ \
	&& touch /root/.ssh/authorized_keys \
	&& chmod u=rwx,g=,o= /root/.ssh \
	&& chmod u=r,g=,o= /root/.ssh/authorized_keys \
	&& rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "ClientAliveInterval 120" >> /etc/ssh/sshd_config && \  
    echo "ClientAliveCountMax 720" >> /etc/ssh/sshd_config && \
    echo "Port 2222" >> /etc/ssh/sshd_config

EXPOSE 2222

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.11/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl &&  mv ./kubectl /usr/local/bin/kubectl

RUN curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.9.0/kind-$(uname)-amd64
RUN chmod +x ./kind && mv ./kind /usr/local/bin/kind

RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

RUN curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.8.1 TARGET_ARCH=x86_64 sh - 

COPY ./entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

COPY ./kind-config.yaml ./kind-config.yaml
COPY ./k8s_configs /k8s_configs

CMD ./entrypoint.sh