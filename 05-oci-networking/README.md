# 05 - OCI Networking Foundation

This section documents the Oracle Cloud Infrastructure network foundation built for the hands-on compute labs.

## Lab configuration

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
| Internet gateway | OCI-LAB-IGW |
| Public route table | OCI-LAB-PUBLIC-RT |
| Private route table | OCI-LAB-PRIVATE-RT |

## Design

The VCN was created as the reusable network foundation for later OCI compute and storage exercises.

The public subnet is associated with a route table containing a default route:

```text
Destination: 0.0.0.0/0
Target:      OCI-LAB-IGW
```

This allows resources with public IP addresses in the public subnet to reach the internet through the Internet Gateway.

A separate private subnet and route table were also created to preserve the public/private network separation in the lab design.

## Service-limit observation

During the build, the tenancy reported a service limit of zero for NAT Gateways and Service Gateways per VCN. Because of that limit, the private route table was intentionally left without NAT or Service Gateway routes.

This was treated as a lab constraint rather than bypassed with a different design.

## Validation checkpoints

The completed network showed:

- VCN state: `Available`
- Public subnet: `10.10.10.0/24`
- Private subnet: `10.10.20.0/24`
- Internet Gateway: `Available`
- Public route table: one rule to `0.0.0.0/0` through `OCI-LAB-IGW`
- Private route table: created and available with no outbound gateway rule

## Next use

The public subnet is used by the Compute VM lab in the next section.

> This is a disposable personal lab. Production VCN design should use routing, security, private connectivity, service gateways, NAT, NSGs/security lists, and IAM controls appropriate to the workload.
