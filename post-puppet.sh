#!/bin/bash
#https://github.com/ffnord/ffnord-puppet-gateway

VPN_NUMBER=03
DOMAIN=nordheide.freifunk.net
TLD=ffnh
IP6PREFIX=fd8f:14c7:d318

# firewall config
build-firewall

#fastd ovh config
cd /etc/fastd/ffnh-mvpn/
git clone https://github.com/freifunk-nordheide/nordheide-gw-peers-ovh backbone
touch /usr/local/bin/update-fastd-gw
cat <<-EOF>> /usr/local/bin/update-fastd-gw
#!/bin/bash

cd /etc/fastd/ffnh-mvpn/backbone
git pull -q
EOF
chmod +x /usr/local/bin/update-fastd-gw

# check if everything is running:
check-services
echo 'maintenance off if needed !'
echo 'adapt hostname in the OVH-template /etc/cloud/templates/hosts.debian.tmpl and reboot'
echo 'add "include peers from "nordheide-gw-peers-ovh";" to fastd.conf'
