# 06 - OCI Compute VM Provisioning

This section documents provisioning and validating an Oracle Cloud Infrastructure Compute instance using the network foundation from the previous section.

## Instance configuration

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
| Boot-volume in-transit encryption | Enabled |
| Instance Metadata Service | Version 2 only |

## Networking

The primary VNIC was attached to `OCI-LAB-PUBLIC-SUBNET`.

The instance received:

- private address from `10.10.10.0/24`
- an ephemeral public IPv4 address for lab access
- a private DNS record
- hostname `oci-lab-vm01`

The exact public IP is intentionally not stored in this repository because it is ephemeral lab data.

## Access

OCI generated an SSH key pair during provisioning.

The private key remains outside this repository and is excluded by `.gitignore`.

The default Oracle Linux account used for administrative access is:

```text
opc
```

## Storage

The instance was created with its default boot volume.

Validation in the OCI console confirmed:

- boot volume state: `Attached`
- size: 47 GB
- in-transit encryption: enabled
- image: Oracle Linux 9.8

Additional block volumes are covered separately so storage attachment and persistence can be validated independently.

## Provisioning validation

The OCI work request completed successfully and the instance reached:

```text
Running
```

The OCI console was then used to validate the instance details, primary VNIC, boot volume, and console access.

## Console connection

An OCI Cloud Shell console connection was created and reached the serial-console login prompt for:

```text
oci-lab-vm01 login:
```

The serial console was used only as a validation/troubleshooting path. Normal administration is performed through SSH.

See [validation-commands.sh](validation-commands.sh) for the guest operating-system validation commands used after login.
