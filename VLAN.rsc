# Basic VLAN Setup for Internet Traffic

# Configure VLAN interfaces
/interface vlan
add name=vlan10 vlan-id=10 interface=ether1
add name=vlan20 vlan-id=20 interface=ether1

# Configure IP addresses for VLAN interfaces
/ip address
add interface=vlan10 address=192.168.10.1/24
add interface=vlan20 address=192.168.20.1/24

# Enable DHCP server for VLANs
/ip dhcp-server
add name=dhcp10 interface=vlan10 address-pool=dhcp10_pool
add name=dhcp20 interface=vlan20 address-pool=dhcp20_pool

# Configure DHCP address pools for VLANs
/ip pool
add name=dhcp10_pool ranges=192.168.10.2-192.168.10.254
add name=dhcp20_pool ranges=192.168.20.2-192.168.20.254

# Add default gateways for VLANs
/ip route
add gateway=192.168.10.1
add gateway=192.168.20.1

#////////////////////////////////////////////////////////////

# Advanced VLAN Setup for Internet Traffic

# Configure VLAN interfaces
/interface vlan
add name=vlan10 vlan-id=10 interface=ether1
add name=vlan20 vlan-id=20 interface=ether1

# Configure IP addresses for VLAN interfaces
/ip address
add interface=vlan10 address=192.168.10.1/24
add interface=vlan20 address=192.168.20.1/24

# Enable DHCP server for VLANs
/ip dhcp-server
add name=dhcp10 interface=vlan10 address-pool=dhcp10_pool
add name=dhcp20 interface=vlan20 address-pool=dhcp20_pool

# Configure DHCP address pools for VLANs
/ip pool
add name=dhcp10_pool ranges=192.168.10.2-192.168.10.254
add name=dhcp20_pool ranges=192.168.20.2-192.168.20.254

# Configure Firewall rules for VLANs
/ip firewall filter
add chain=forward action=accept src-address=192.168.10.0/24 dst-address=192.168.20.0/24 comment="Allow VLAN10 to VLAN20"
add chain=forward action=accept src-address=192.168.20.0/24 dst-address=192.168.10.0/24 comment="Allow VLAN20 to VLAN10"
add chain=forward action=drop comment="Drop other traffic"

# Configure NAT for VLANs
/ip firewall nat
add chain=srcnat out-interface=vlan10 action=masquerade
add chain=srcnat out-interface=vlan20 action=masquerade

# Add default gateways for VLANs
/ip route
add gateway=192.168.10.1
add gateway=192.168.20.1