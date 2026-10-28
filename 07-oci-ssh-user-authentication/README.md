# 07 - OCI Compute SSH Access and OS User Authentication

This section extends the Compute VM lab by validating two different operating-system access models on the same Oracle Linux instance.

## Access models validated

| Account | Authentication | Purpose |
| --- | --- | --- |
| opc | SSH public key | Default OCI administrative access |
| shussaini | Password | User-specific lab authentication example |

## Baseline SSH validation

The default `opc` account was accessed with the SSH key generated during instance provisioning.

The running OpenSSH service was validated with:

```bash
sudo systemctl is-active sshd
sudo sshd -T | grep -E '^(pubkeyauthentication|passwordauthentication|permitrootlogin)'
sudo ss -lntp | grep ':22'
```

The observed baseline included:

```text
permitrootlogin without-password
pubkeyauthentication yes
passwordauthentication no
```

This confirmed that the default OCI access remained key-based.

## Local user creation

A separate local account was created for the password-authentication exercise:

```bash
sudo useradd -m -s /bin/bash shussaini
sudo passwd shussaini
id shussaini
getent passwd shussaini
```

The account was created with a normal home directory and Bash shell. No password is stored in this repository.

## User-specific SSH policy

Instead of enabling password authentication globally, a dedicated OpenSSH drop-in file was created:

```text
/etc/ssh/sshd_config.d/60-shussaini-password.conf
```

The exact lab configuration is stored in [60-shussaini-password.conf](60-shussaini-password.conf).

It uses a `Match User` block so the password authentication change applies only to `shussaini` while the existing `opc` key-based model remains unchanged.

## Configuration validation

Before restarting SSH, the configuration syntax was checked:

```bash
sudo sshd -t
echo $?
```

The syntax check returned:

```text
0
```

The effective configuration for the user was then validated with:

```bash
sudo sshd -T -C user=shussaini,host=oci-lab-vm01,addr=127.0.0.1 \
  | grep -E '^(passwordauthentication|pubkeyauthentication|kbdinteractiveauthentication|authenticationmethods)'
```

The effective settings were:

```text
pubkeyauthentication no
passwordauthentication yes
kbdinteractiveauthentication no
authenticationmethods password
```

After validation:

```bash
sudo systemctl restart sshd
sudo systemctl is-active sshd
```

The service returned `active`.

## Login validation

A new SSH session was opened as:

```text
shussaini@<ephemeral-public-ip>
```

and authenticated with the user's password.

After login, the session was validated with:

```bash
whoami
hostname
id
pwd
date
```

The user remained a standard local account and was not added to the `wheel` group.

## Security note

Password-only SSH access was enabled here deliberately as an educational lab scenario for a single user.

For production environments, access should follow the organization's security standard, such as controlled SSH keys, centralized identity, PAM/bastion access, short-lived credentials, MFA-backed access paths, restricted source networks, and least privilege.

Private keys and passwords are never committed to this repository.
