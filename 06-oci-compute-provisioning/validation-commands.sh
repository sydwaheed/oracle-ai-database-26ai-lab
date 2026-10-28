#!/usr/bin/env bash
# OCI-LAB-VM01 guest validation commands
# Run interactively after connecting to the instance.

date
hostnamectl
cat /etc/os-release
ip addr show
ip route
whoami
uptime

# OCI Instance Metadata Service v2
curl -s -H "Authorization: Bearer Oracle" \
  http://169.254.169.254/opc/v2/instance/displayName
echo

curl -s -H "Authorization: Bearer Oracle" \
  http://169.254.169.254/opc/v2/instance/hostname
echo

curl -s -H "Authorization: Bearer Oracle" \
  http://169.254.169.254/opc/v2/instance/shape
echo

curl -s -H "Authorization: Bearer Oracle" \
  http://169.254.169.254/opc/v2/instance/region
echo
