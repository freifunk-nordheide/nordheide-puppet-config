# Install scripts for a Freifunk Nordheide Gateway

## First, make shure your system is debian jessie, system ist up to date. git has to be installed.
## A screen session is required. 

### 1. change to /opt
    cd /opt

### 2. clone nordheide-puppet-config
    git clone https://github.com/freifunk-nordheide/nordheide-puppet-config
    
### 3. change to nordheide-puppet-config
    cd nordheide-puppet-config

### 4. create the file with the fastd private key
    echo 'secret "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";' > /root/fastd_secret.key

### 3. copy this file to the root home folder:
    cp gw00.pp /root/gw00.pp
    
and adapt all needed settings to the new gateway ( eg vpn user and password ) 

### 4. start the pre-puppet script
    sh pre-puppet.sh
    
### 5. run the puppet-script
    puppet apply --verbose /root/gw0n.pp
    
### 6. start the post-puppet-script
    sh post-puppet.sh
    
### 7. build the firewall
    build-firewall
    
### 8. restart the vpn connection
    service openvpn restart
    
### 9. edit /etc/ffnord and insert an known pingable host. eg 8.8.8.8 @ GW_CONTROL_IP
    nano /etc/ffnord
    
### 10. exit maintenance mode
    maintenance off
    
### 11. run checkgateway script. if it returns without an error, dude, you're done with this job!!!
    check-gateway

### 12. create addtitional user and garant root to them

    adduser newuser
    adduser newuser sudo
    
### 13. reboot machine
    reboot
