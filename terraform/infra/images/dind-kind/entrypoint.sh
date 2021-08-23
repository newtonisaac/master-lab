#!/bin/sh

set -e
# X forward version

#SSHD
# prepare keys
if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]; then
	# generate fresh rsa key
	ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
fi
if [ ! -f "/etc/ssh/ssh_host_dsa_key" ]; then
	# generate fresh dsa key
	ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
fi
#prepare run dir
if [ ! -d "/var/run/sshd" ]; then
	mkdir -p /var/run/sshd
fi

# unlock root user for ssh user
echo "root:admin" | chpasswd

# start logging for ssh
echo "starting syslog"
syslogd &

# start sshd
echo "starting ssshd"
/usr/sbin/sshd -D &

# reread all config
source /etc/profile

# deploy authorized_keys
if [ ! -z "${AUTHORIZED_KEYS}" ]; then
    echo "${AUTHORIZED_KEYS//$'\n'/\n}" > /root/.ssh/authorized_keys
fi

trap 'exit 0' SIGINT
while true; do :; done