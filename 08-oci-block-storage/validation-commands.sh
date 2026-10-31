#!/bin/bash
# Validation commands used for the OCI Block Volume lab.

df -hT /u01 /u02

findmnt /u01
findmnt /u02

lsblk -o NAME,SIZE,TYPE,FSTYPE,UUID,MOUNTPOINTS

grep -E '^[^#].*[[:space:]]/u0[12][[:space:]]' /etc/fstab

sudo touch /u01/oci_bv_test
sudo touch /u02/oci_bv_test

ls -l /u01/oci_bv_test /u02/oci_bv_test

sudo rm -f /u01/oci_bv_test /u02/oci_bv_test
