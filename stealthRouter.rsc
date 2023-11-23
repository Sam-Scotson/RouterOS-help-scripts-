# Address lists for trusted sites, dns and devices
/ip firewall address-list
add list=trusted-sites address=142.251.32.46 comment="google.com"
add list=trusted-sites address=159.148.172.205 comment="mikrotik"

/ip firewall address-list
add list=trusted-dns address=8.8.8.8 comment="Trusted Prime DNS"
add list=trusted-dns address=8.8.4.4 comment="Trusted Back-up DNS"

/ip firewall address-list
add list=trusted-devices address=192.168.1.1 comment="Trusted Device 1"
add list=trusted-devices address=192.168.1.2 comment="Trusted Device 2"

# Configure Stealth Mode - Only respond to ICMP Echo from trusted IPs
/ip firewall filter
add chain=input action=accept protocol=icmp icmp-options=8:0 src-address-list=trusted-icmp comment="Allow ICMP Echo from trusted IPs"
add chain=input action=drop in-interface=dmz comment="Drop all incoming traffic to DMZ except ICMP Echo"

# Remote SSH Management - Allow SSH only from trusted IPs and devices
/ip ssh set strong-crypto=yes
/ip firewall filter
add chain=input action=accept protocol=tcp dst-port=22 src-address-list=trusted-ssh comment="Allow SSH from trusted IPs"
add chain=input action=accept protocol=tcp dst-port=22 src-address-list=trusted-devices comment="Allow SSH from trusted devices"
add chain=input action=drop in-interface=dmz comment="Drop all incoming traffic to DMZ except SSH"

# DMZ WAN-LAN bridge 
/interface bridge add name=dmz comment="DMZ Bridge"

/interface ethernet set [ find default-name=ether2 ] name=eth2lan
/ip address add address=192.168.1.1/24 interface=lan
/ip pool add name=dhcPool ranges=192.168.1.2-192.168.1.254
/ip dhcp-server add name=dhcp-lan interface=lan address-pool=dhcPool

/interface ethernet set [ find default-name=ether5 ] name=eth5wan
/ip dhcp-client add interface=wan disabled=no

/interface bridge port
add bridge=dmz interface=eth2lan comment="Add LAN to DMZ bridge"
add bridge=dmz interface=eth5wan comment="Add WAN to DMZ bridge"

/ip firewall filter
add chain=forward action=drop in-interface=dmz comment="Drop all forwarding traffic in DMZ by default"

# Allow traffic from LAN to DMZ
/ip firewall filter
add chain=forward action=accept in-interface=lan out-interface=dmz comment="Allow traffic from LAN to DMZ"

# Allow traffic from DMZ to WAN
/ip firewall filter
add chain=forward action=accept in-interface=dmz out-interface=wan comment="Allow traffic from DMZ to WAN"

# NAT 
/ip firewall nat
add chain=srcnat out-interface=wan action=masquerade

# Allow HTTPS from trusted sites to DMZ
/ip firewall filter
add chain=forward action=accept protocol=tcp dst-port=443 src-address-list=trusted-sites in-interface=dmz comment="Allow HTTPS from trusted sites to DMZ"

/ip dns set servers=8.8.8.8,8.8.4.4

# Back-door eth interface 
/tool mac-server
add interface=eth1

/tool mac-server mac-winbox
set allowed-interface-list=eth1

/tool mac-server access
add mac-address=00:11:22:33:44:55 comment="MGMT Device 1"
add mac-address=AA:BB:CC:DD:EE:FF comment="MGMT Device 2"
