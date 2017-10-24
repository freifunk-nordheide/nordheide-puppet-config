class {
'ffnord::params':
  router_id      => "10.71.3.1", # The id of this router, probably the ipv4 address
                                  # of the mesh device of the providing community
  icvpn_as       => "64889",      # The as of the providing community
  wan_devices    => ['eth0'],     # An array of devices which should be in the wan zone

  include_bird4  => false,

  wmem_default   => 87380,        # Define the default socket send buffer
  wmem_max       => 12582912,     # Define the maximum socket send buffer
  rmem_default   => 87380,        # Define the default socket recv buffer
  rmem_max       => 12582912,     # Define the maximum socket recv buffer

  gw_control_ips => "8.8.8.8", # Define target to ping against for function check
  max_backlog    => 5000, # Define the maximum packages in buffer

  conntrack_max => 32768,
  conntrack_tcp_timeout => 1200,
  conntrack_udp_timeout => 65,

  maintenance    => 1,
  batman_version => 15,
}

ffnord::mesh {
 'mesh_ffnord':
    mesh_name       => "Freifunk Nordheide"
  , mesh_code       => "ffnh"
  , mesh_as         => "64889"
  , mesh_mac        => "fe:ed:be:ef:ff:02"
  , vpn_mac         => "fe:ed:be:ef:ff:02"
  , mesh_ipv6       => "fd8f:14c7:d318::ff02/64"
  , mesh_ipv4       => "10.71.3.1/19"
  , range_ipv4      => "10.71.0.0/18"
  , mesh_mtu        => "1374"
  , mesh_peerings   => "/root/mesh_peerings.yaml"

  , fastd_secret    => "/root/02gw-fastd-secrect.key"
  , fastd_port      => 10050
  , fastd_peers_git => 'https://github.com/freifunk-nordheide/nordheide-peers.git'

  , dhcp_ranges     => ['10.71.3.2 10.71.4.254']
  , dns_servers     => ['10.71.3.1'] # should be the same as $router_id
}

class {'ffnord::vpn::provider::pia':
  openvpn_server    => "germany.privateinternetaccess.com",
  openvpn_port      => 3478,
  openvpn_user      => "xxxxxxx",
  openvpn_password  => "xxxxxxxx";
}

ffnord::named::zone {
  "ffnh": zone_git => "https://github.com/freifunk-nordheide/nordheide-zone.git", exclude_meta => 'nordheide';
}

class {
  ['ffnord::etckeeper','ffnord::rsyslog']:
}

# Useful packages
package {
  ['vim','tcpdump','dnsutils','realpath','screen','htop','mlocate','tig']:
     ensure => installed;
}
