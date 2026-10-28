# 06 - OCI Compute VM Provisioning

I created an Oracle Linux Compute instance using the VCN and public subnet from the previous lab.

## Instance settings

| Setting | Value |
| --- | --- |
| Instance name | OCI-LAB-VM01 |
| Compartment | QUALTIQ-WEB |
| Region | India West (Mumbai) |
| Availability domain | AD-1 |
| Fault domain | FD-1 |
| Capacity | On-demand |
| Operating system | Oracle Linux Server 9.8 |
| Image | Oracle-Linux-9.8-2026.10.16-0 |
| Shape | VM.Standard.E2.1.Micro |
| OCPU | 1 |
| Memory | 1 GB |
| VCN | OCI-LAB-VCN |
| Subnet | OCI-LAB-PUBLIC-SUBNET |
| Private IPv4 | Automatically assigned |
| Public IPv4 | Automatically assigned |
| Boot volume | 47 GB |
| In-transit encryption | Enabled |
| Instance Metadata Service | Version 2 only |

## VNIC and addresses

The primary VNIC was attached to `OCI-LAB-PUBLIC-SUBNET`.

OCI assigned a private address from `10.10.10.0/24` and an ephemeral public IPv4 address.

A private DNS record was also created with hostname:

```text
oci-lab-vm01
```

I have not stored the public IP in this repository because it is temporary.

## SSH key

During instance creation I selected the option for OCI to generate the SSH key pair.

The private key is kept outside the repository. Key files are excluded in `.gitignore`.

The default Oracle Linux login user is:

```text
opc
```

## Boot volume

OCI created the boot volume as part of the instance build.

The Storage page showed:

```text
State                  Attached
Size                   47 GB
In-transit encryption  Enabled
Image                  Oracle Linux 9.8
```

No additional block volume was attached during this activity.

## Provisioning check

The create instance work request completed with `Succeeded` and the instance status changed to `Running`.

I then checked the instance details, networking and storage pages in the OCI console.

## Console check

I also launched an OCI Cloud Shell console connection. It reached the serial console login prompt:

```text
oci-lab-vm01 login:
```

This confirmed that the console connection path was working. I kept normal administration separate and used SSH for the next lab.

The OS checks used after login are in [validation-commands.sh](validation-commands.sh).
