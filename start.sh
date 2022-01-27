#!/bin/bash

git config --global user.email $GEMAIL
git config --global user.name $GNAME

# copy ssh keys
cp /mnt/.ssh/id_rsa /root/.ssh/id_rsa
cp /mnt/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub
cp /mnt/.ssh/id_rsa.pub /root/.ssh/authorized_keys

/usr/sbin/sshd -De
