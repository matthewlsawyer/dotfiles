# pi_omv

**Stale runbook** — OMV arrakis / PHP 7.0 era. No `apply.sh`. Verify package names against [current OMV](https://www.openmediavault.org/) before use. [MODERNIZATION.md](../MODERNIZATION.md)

Host disk layout: [hosts/pi-omv/](../hosts/pi-omv/). `./dotfiles.sh pi_omv` (profile) or `./dotfiles.sh pi-omv` (host).

## Base setup

```bash
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install -y vim git
sudo raspi-config
```

## OMV install

```bash
echo "deb http://packages.openmediavault.org/public arrakis main" | sudo tee -a /etc/apt/sources.list.d/openmediavault.list
sudo apt-get update
wget -O - http://packages.openmediavault.org/public/archive.key | sudo apt-key add -
sudo apt-get install -y --allow-unauthenticated openmediavault-keyring
sudo apt-get update
sudo apt-get install -y openmediavault
sudo apt-get install --reinstall -y resolvconf
sudo omv-initsystem
wget -O - http://omv-extras.org/install | bash   # optional
```

```bash
adduser -m $user
```

Disk layout: [hosts/pi-omv/disk-layout.md](../hosts/pi-omv/disk-layout.md)

## Samba

```bash
sudo smbpasswd -a $user
sudo mount -t cifs //$server/Public /mnt/path/to/Public -o user=$user,uid=$user,gid=users
```

## Nginx 502 fix

Install `openmediavault-nginx` plugin. In `/etc/php/7.0/fpm/pool.d/www.conf`:

```conf
listen.owner = www-data
listen.group = www-data
listen.mode = 0660
```

In `/etc/nginx/sites-enabled/openmediavault-webgui`:

```nginx
location / {
    try_files $uri $uri/ /index.php?$query_string;
}
```

```bash
sudo service nginx restart
sudo service php7.0-fpm restart
sudo apt-get install --reinstall libpcre3
```

## Monit fix

If config changes fail with `monit.service is not active`:

```bash
sudo systemctl edit monit
```

```ini
[Service]
PIDFile=/var/run/monit.pid
Restart=always
RemainAfterExit=no
```

```bash
sudo systemctl daemon-reload && sudo systemctl restart monit
```
