# The Oracle Runbook - OCI Cloud Labs

This repository contains my hands-on Oracle Cloud lab work. It started with Oracle AI Database 26ai and now includes the OCI network and Compute environment used for the next labs.

Everything here was built in my personal lab. I do not use customer or employer environment details in this repository.

## Lab contents

| Section | Work completed |
| --- | --- |
| [01-autonomous-database-setup](01-autonomous-database-setup/) | Created an Autonomous AI Database 26ai instance |
| [02-database-validation](02-database-validation/) | Checked database version and session details from SQL |
| [03-relational-sql](03-relational-sql/) | Created a table and tested normal DDL and DML |
| [04-vector-search](04-vector-search/) | Tested the VECTOR datatype and cosine distance |
| [05-oci-networking](05-oci-networking/) | Created the VCN, public and private subnets, Internet Gateway and route tables |
| [06-oci-compute-provisioning](06-oci-compute-provisioning/) | Created an Oracle Linux Compute VM and checked its network, boot volume, metadata and console access |
| [07-oci-ssh-user-authentication](07-oci-ssh-user-authentication/) | Tested the default key based login and a separate password based OS user |

## Current lab environment

| Item | Value |
| --- | --- |
| Cloud | Oracle Cloud Infrastructure |
| Region | India West (Mumbai) |
| Compartment | QUALTIQ-WEB |
| VCN | OCI-LAB-VCN |
| VCN CIDR | 10.10.0.0/16 |
| Compute instance | OCI-LAB-VM01 |
| Operating system | Oracle Linux Server 9.8 |
| Compute shape | VM.Standard.E2.1.Micro |
| Database service | Autonomous AI Database Serverless |
| Database version | Oracle AI Database 26ai |

## Oracle AI Database 26ai

The database was created as an Autonomous AI Database Serverless instance with the Transaction Processing workload.

I first checked the database from SQL, then created a small relational table and finally tested the native `VECTOR` datatype.

The vector values are simple three dimensional test values that I entered manually. They are only used to make the distance calculation easy to follow.

Reference vector:

```text
[1,0,0]
```

| Item | Cosine distance |
| --- | ---: |
| Oracle Database Administration | 0 |
| RMAN Backup and Recovery | 0.006116 |
| Data Guard High Availability | 0.036913 |
| Linux System Administration | 1 |

## OCI network

The VCN uses `10.10.0.0/16`.

Public subnet:

```text
10.10.10.0/24
Default route 0.0.0.0/0 through OCI-LAB-IGW
```

Private subnet:

```text
10.10.20.0/24
```

The tenancy used for this lab showed a limit of zero for NAT Gateway and Service Gateway creation, so the private route table currently has no outbound gateway route.

## OCI Compute

`OCI-LAB-VM01` was created with Oracle Linux Server 9.8 on the Always Free eligible `VM.Standard.E2.1.Micro` shape.

I checked the following after provisioning:

1. Work request status
2. Image and shape
3. Primary VNIC
4. Public and private IPv4 addresses
5. Boot volume
6. Instance Metadata Service v2
7. Serial console access from OCI Cloud Shell

## SSH access

The normal `opc` account continues to use SSH key authentication.

For a separate lab test, I created the local user `shussaini` and used an OpenSSH `Match User` configuration to allow password authentication only for that account.

The SSH configuration was syntax checked before the service was restarted.

## Run order

1. [Autonomous AI Database setup](01-autonomous-database-setup/)
2. [Database validation](02-database-validation/)
3. [Relational SQL](03-relational-sql/)
4. [Vector search](04-vector-search/)
5. [OCI networking](05-oci-networking/)
6. [OCI Compute provisioning](06-oci-compute-provisioning/)
7. [SSH and OS user authentication](07-oci-ssh-user-authentication/)

The next lab will cover OCI Block Volume storage with both paravirtualized and iSCSI attachment methods.

## Notes

No passwords, private keys, wallet files or other credentials are stored in this repository.

Public IP addresses used by temporary lab resources are also not recorded here.

Production environments need security, network, IAM, monitoring and operating system controls that match the organization and workload.

## References

* [Oracle AI Database 26ai Documentation](https://docs.oracle.com/en/database/oracle/oracle-database/26/)
* [Oracle Autonomous AI Database Documentation](https://docs.oracle.com/en/cloud/paas/autonomous-database/)
* [Oracle Cloud Infrastructure Documentation](https://docs.oracle.com/en-us/iaas/Content/home.htm)
* [Oracle Linux Documentation](https://docs.oracle.com/en/operating-systems/oracle-linux/)

## Author

Syed Waheeduddin Hussaini

The Oracle Runbook  
GitHub: [@sydwaheed](https://github.com/sydwaheed)  
Medium: [@sydwaheed](https://medium.com/@sydwaheed)
