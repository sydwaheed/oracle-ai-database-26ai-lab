#!/usr/bin/env bash
# OpenSSH validation commands used in the OCI-LAB-VM01 lab.

sudo systemctl is-active sshd

sudo sshd -T \
  | grep -E '^(pubkeyauthentication|passwordauthentication|permitrootlogin)'

sudo ss -lntp | grep ':22'

id shussaini
getent passwd shussaini

sudo sshd -t

sudo sshd -T -C user=shussaini,host=oci-lab-vm01,addr=127.0.0.1 \
  | grep -E '^(passwordauthentication|pubkeyauthentication|kbdinteractiveauthentication|authenticationmethods)'

sudo systemctl restart sshd
sudo systemctl is-active sshd
