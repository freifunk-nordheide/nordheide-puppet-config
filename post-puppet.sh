#!/bin/bash
#https://github.com/ffnord/ffnord-puppet-gateway

VPN_NUMBER=11
DOMAIN=nordheide.freifunk.net
TLD=ffnord
IP6PREFIX=fd8f:14c7:d318

# alfred fix for /bin/sh
sed -i 's/( //;s/ )//g' /etc/ffnord
service alfred restart
cd
puppet apply --verbose $VPN_NUMBER.gateway.pp
sed -i 's/( //;s/ )//g' /etc/ffnord

# firewall config
build-firewall

#fastd ovh config
cd /etc/fastd/ffnord-mvpn/
git clone https://github.com/freifunk-nordheide/nordheide-gw-peers-ovh backbone
touch /usr/local/bin/update-fastd-gw
cat <<-EOF>> /usr/local/bin/update-fastd-gw
#!/bin/bash

cd /etc/fastd/ffnord-mvpn/backbone
git pull -q
EOF
chmod +x /usr/local/bin/update-fastd-gw

# check if everything is running:
check-services
echo 'maintenance off if needed !'
echo 'adapt hostname in the OVH-template /etc/cloud/templates/hosts.debian.tmpl and reboot'
echo 'add "include peers from "nord-gw-peers-ovh";" to fastd.conf'
