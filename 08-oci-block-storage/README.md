# 08 - OCI Block Volume Storage

In this lab I added two OCI Block Volumes to the existing Oracle Linux Compute instance and tested both supported attachment approaches used in the activity.

| Volume | Size | Attachment | Linux device | Filesystem | Mount point |
| --- | ---: | --- | --- | --- | --- |
| OCI-LAB-BV-U01 | 50 GB | Paravirtualized | /dev/sdb | XFS | /u01 |
| OCI-LAB-BV-U02 | 100 GB | iSCSI | /dev/sdc | XFS | /u02 |

## Paravirtualized volume - /u01

I created `OCI-LAB-BV-U01` as a 50 GB Balanced block volume and attached it to `OCI-LAB-VM01` using the paravirtualized attachment type.

After attachment, Linux detected the disk as `/dev/sdb`.

Before creating the filesystem I checked for existing signatures:

```bash
sudo wipefs -n /dev/sdb
```

I then created XFS and the mount point:

```bash
sudo mkfs.xfs /dev/sdb
sudo mkdir -p /u01
sudo blkid /dev/sdb
```

The filesystem UUID was used in `/etc/fstab` instead of relying on the transient `/dev/sdX` name:

```text
UUID=c86190d4-9459-48d4-a110-08aca5984e10 /u01 xfs defaults,_netdev,nofail 0 2
```

## iSCSI volume - /u02

I created `OCI-LAB-BV-U02` as a 100 GB Balanced block volume and attached it using iSCSI.

The OCI attachment page provided the iSCSI target information and connection commands. After the session was established, I checked the Linux block device view and reviewed the OCI Cloud Agent Block Volume Management plugin.

The OCI device path used for filesystem creation was:

```text
/dev/oracleoci/oraclevdb
```

I created XFS and the mount point:

```bash
sudo mkfs.xfs /dev/oracleoci/oraclevdb
sudo mkdir -p /u02
sudo blkid /dev/oracleoci/oraclevdb
```

The persistent mount entry used the filesystem UUID:

```text
UUID=a673ade3-c7f1-42f4-86de-d4e25af9d20c /u02 xfs defaults,_netdev,nofail,noatime 0 2
```

## Mount validation

After updating `/etc/fstab`, I reloaded systemd and mounted the filesystems:

```bash
sudo systemctl daemon-reload
sudo mount -a
```

I validated both mount points with:

```bash
df -hT /u01 /u02
findmnt /u01
findmnt /u02
lsblk -o NAME,SIZE,TYPE,FSTYPE,UUID,MOUNTPOINTS
```

I also performed simple write tests on both filesystems.

## Reboot persistence test

After both volumes were configured, I rebooted `OCI-LAB-VM01` specifically to verify persistent mounting.

After reconnecting through SSH, both `/u01` and `/u02` were present without running a manual mount command.

I repeated the filesystem and write checks after the reboot to confirm that the UUID-based `/etc/fstab` configuration worked as expected.

## Final state

The OCI Compute Storage view and the Oracle Linux guest view were checked together before the activity was considered complete.

The final state was:

- `OCI-LAB-BV-U01` attached paravirtualized and mounted persistently as `/u01`
- `OCI-LAB-BV-U02` attached through iSCSI and mounted persistently as `/u02`
- Both filesystems formatted as XFS
- Both mount definitions based on filesystem UUIDs
- Both mounts successfully restored after a full VM reboot

No credentials or sensitive connection information are stored in this repository.
