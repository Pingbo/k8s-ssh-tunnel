#!/bin/sh -e

if [ -n "$AUTHORIZED_KEY" ]; then
    #echo $AUTHORIZED_KEY >> /root/.ssh/authorized_keys
    mkdir /home/tunnel/.ssh
    chmod 700 /home/tunnel/.ssh
    touch /home/tunnel/.ssh/authorized_keys
    chmod 600 /home/tunnel/.ssh/authorized_keys
    echo $AUTHORIZED_KEY >> /home/tunnel/.ssh/authorized_keys
    chown -R tunnel:tunnel /home/tunnel/.ssh
    /usr/sbin/sshd -D
else
    echo "Environment variable AUTHORIZED_KEY is missing, generating password"
    PASSWORD=$(</dev/urandom tr -dc 'A-Za-z0-9!"#$%&'\''()*-/=?' | head -c 10)
    echo "tunnel:$PASSWORD" | chpasswd
    echo "Please find below the Credentials:
        Username: tunnel
        Password: $PASSWORD"
    /usr/sbin/sshd -D
fi