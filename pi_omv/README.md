# Raspberry Pi with Open Media Vault

> **Stale runbook** — written for OMV arrakis / PHP 7.0 era. Hardware may be rebuilt; verify current OMV release and package names before following these steps. No scripts in this directory — procedural notes only.

**Status:** Repurpose — NAS hardware exists; may rebuild with updated OMV.

---

## Before rebuilding

- Check the [current OMV release](https://www.openmediavault.org/) — arrakis is outdated.
- Replace `apt-key add` with a signed-by keyring pattern.
- PHP/nginx paths will differ — the 502 fix references `php7.0-fpm`; adjust for your OMV version.
- Disk layout is hardware-specific — see [LVM.md](LVM.md); adapt `/dev/sd*` to your setup.
- Future: extract steps into `scripts/` — see [MODERNIZATION.md](../MODERNIZATION.md).

---

First thing we want to do is get everything up to date and get some useful packages.

```bash
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get update
sudo apt-get install -y vim git
```

Next we want to set up the pi, making sure to set the locale.

```bash
sudo raspi-config
```

---

## OMV

### Installation

```bash
# Install OMV
echo "deb http://packages.openmediavault.org/public arrakis main" | sudo tee -a /etc/apt/sources.list.d/openmediavault.list
sudo apt-get update
wget -O - http://packages.openmediavault.org/public/archive.key | sudo apt-key add -
sudo apt-get install -y --allow-unauthenticated openmediavault-keyring
sudo apt-get update

# This will prompt you for mail setup
sudo apt-get install -y openmediavault

# Replace openresolv with resolvconf
sudo apt-get install --reinstall -y resolvconf

# Initialize OMV
sudo omv-initsystem

# If you want to enable OMV Extras
wget -O - http://omv-extras.org/install | bash
```

Next we want to create a user that we will put in the `ssh` and `sudo` groups. We want to use the terminal to do this
because OMV won't create a home directory for us.

```bash
adduser -m $user
```

Disk layout: [LVM.md](LVM.md)

---

## Samba

Make sure that if you create a `samba` password for your users.

```bash
sudo smbpasswd -a $user
```

And then the client can mount that drive with the following command.

```bash
sudo mount -t cifs //$server/Public /mnt/path/to/Public -o user=$user,uid=$user,gid=users
```

---

## Nginx

If you want to run `nginx` on OMV to enable something like Nextcloud etc.

### Installation

First install the `openmediavault-nginx` plugin. To fix the "502 Bad Gateway" bug, we need to edit
the file `/etc/php/7.0/fpm/pool.d/www.conf` and un-comment or add the following lines.

```conf
listen.owner = www-data
listen.group = www-data
listen.mode = 0660
```

And then edit the `/etc/nginx/sites-enabled/openmediavault-webgui` file to include the following
lines.

```bash
location / {
    try_files $uri $uri/ /index.php?$query_string;
}
```

And then restart the services using the scripts below.

```bash
sudo service nginx restart
sudo service php7.0-fpm restart
```

You can also try re-installing `libpcre3` though I'm not sure how much of an effect this has as it
already appeared to be installed properly in my testing.

```bash
# Fix bad gateway errors in php7
sudo apt-get install --reinstall libpcre3
```

---

## Debugging

If you see the following error on any configuration change, it means that `monit` has died.

> systemctl reload 'monit' 2>&1' with exit code '1': monit.service is not active, cannot reload.

To ensure that `monit` will restart when it dies then run the following command.

```bash
sudo systemctl edit monit
```

Then fill in the following configuration:

```
[Service]
PIDFile=/var/run/monit.pid
Restart=always
RemainAfterExit=no
```

And reload the daemon:

```bash
sudo systemctl daemon-reload
sudo systemctl restart monit
```
