# 05 - OCI Networking Foundation

This is the network I created for the OCI Compute and storage labs.

## Configuration

| Setting | Value |
| --- | --- |
| Region | India West (Mumbai) |
| Compartment | QUALTIQ-WEB |
| VCN | OCI-LAB-VCN |
| VCN CIDR | 10.10.0.0/16 |
| Public subnet | OCI-LAB-PUBLIC-SUBNET |
| Public subnet CIDR | 10.10.10.0/24 |
| Private subnet | OCI-LAB-PRIVATE-SUBNET |
| Private subnet CIDR | 10.10.20.0/24 |
| Internet Gateway | OCI-LAB-IGW |
| Public route table | OCI-LAB-PUBLIC-RT |
| Private route table | OCI-LAB-PRIVATE-RT |

## Public subnet

The public route table contains:

```text
Destination  0.0.0.0/0
Target       OCI-LAB-IGW
```

Instances in this subnet can use the Internet Gateway when they have a public IP address and the required security rules.

## Private subnet

I also created a separate private subnet and route table using `10.10.20.0/24`.

While building the lab, OCI showed a service limit of zero for NAT Gateways and Service Gateways per VCN. Because of that account limit, I left the private route table without a NAT or Service Gateway route.

## Final check

The network resources were available with the following layout:

```text
VCN             10.10.0.0/16
Public subnet   10.10.10.0/24
Private subnet  10.10.20.0/24
Internet GW     OCI-LAB-IGW
Public route    0.0.0.0/0 through OCI-LAB-IGW
```

The public subnet is used by `OCI-LAB-VM01` in the next lab.

This is a personal lab design. A production VCN would be built according to the required routing, security and access model.
