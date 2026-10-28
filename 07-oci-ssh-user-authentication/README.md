# 07 - OCI Compute SSH Access and OS User Authentication

In this lab I tested two login methods on the same Oracle Linux VM.

| User | Login method |
| --- | --- |
| opc | SSH key |
| shussaini | Password |

## Default opc login

The `opc` account was accessed with the private key generated when the Compute instance was created.

I checked the SSH service and the effective default settings:

```bash
sudo systemctl is-active sshd
sudo sshd -T | grep -E '^(pubkeyauthentication|passwordauthentication|permitrootlogin)'
sudo ss -lntp | grep ':22'
```

The output included:

```text
permitrootlogin without-password
pubkeyauthentication yes
passwordauthentication no
```

The default OCI login therefore remained key based.

## Creating a second OS user

I created a normal local account:

```bash
sudo useradd -m -s /bin/bash shussaini
sudo passwd shussaini
id shussaini
getent passwd shussaini
```

The password command also showed that the operating system password policy rejects weak passwords. No password is stored here.

## Password login only for this user

I did not enable password authentication for every SSH user.

Instead I created:

```text
/etc/ssh/sshd_config.d/60-shussaini-password.conf
```

with a `Match User shussaini` block.

The configuration used in the lab is in [60-shussaini-password.conf](60-shussaini-password.conf).

## Checking the SSH configuration

Before restarting `sshd` I ran:

```bash
sudo sshd -t
echo $?
```

The return code was `0`.

I also checked the settings that apply specifically to `shussaini`:

```bash
sudo sshd -T -C user=shussaini,host=oci-lab-vm01,addr=127.0.0.1 \
  | grep -E '^(passwordauthentication|pubkeyauthentication|kbdinteractiveauthentication|authenticationmethods)'
```

The result was:

```text
pubkeyauthentication no
passwordauthentication yes
kbdinteractiveauthentication no
authenticationmethods password
```

I restarted the service only after the configuration check passed:

```bash
sudo systemctl restart sshd
sudo systemctl is-active sshd
```

The service returned `active`.

## Login test

I opened a new SSH session as `shussaini` and authenticated with the password set for that account.

After login I checked:

```bash
whoami
hostname
id
pwd
date
```

The account remained a normal local user and was not added to `wheel`.

Password based SSH was used only for this lab exercise. In a production environment I would normally use the access method approved for that environment, such as managed SSH keys, PAM, a bastion or centralized identity.
