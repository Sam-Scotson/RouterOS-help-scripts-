# The following script is to set up a VRRP (Virtual Router Redundancy Protocol) system on MikroTik RouterOS
# Script is for setting up a typical LAN interface with a DMZ and MGMT interface for robust security and managment

:local LAN_VRID 10
:local DMZ_VRID 20
:local MGMT_VRID 30

# Primary Router Configuration

# LAN configuration
/interface vlan
add name=LAN-VLAN-PRI vlan-id=10 interface=ether1
/interface vrrp
add name=LAN-VRRP-PRI vrid=$LAN_VRID interface=LAN-VLAN priority=100 virtual-address=192.168.1.254/24 \
  adver-interval=1s authenticate=yes auth-password= # your password

# DMZ configuration
/interface vlan
add name=DMZ-VLAN-PRI vlan-id=20 interface=ether2
/interface vrrp
add name=DMZ-VRRP-PRI vrid=$DMZ_VRID interface=DMZ-VLAN priority=100 virtual-address=192.168.2.254/24 \
  adver-interval=1s authenticate=yes auth-password= # your password

# MGMT configuration (Physical Interface)
/interface ethernet
add name=MGMT-PRI ether3
/interface vrrp
add name=MGMT-VRRP-PRI vrid=$MGMT_VRID interface=MGMT priority=100 virtual-address=192.168.3.254/24 \
  adver-interval=1s authenticate=yes auth-password= # your password

# External configuration
/interface vlan
add name=external-VLAN-PRI vlan-id=30 interface=ether4
/interface vrrp
add name=external-VRRP-PRI vrid=$MGMT_VRID interface=external-VLAN priority=100 virtual-address=192.168.4.254/24 \
  adver-interval=1s authenticate=yes auth-password= # your password

# Redundant Router Configuration

# LAN configuration using VLAN
/interface vlan
add name=LAN-VLAN-RED vlan-id=10 interface=ether1
/interface vrrp
add name=LAN-VRRP-RED vrid=$LAN_VRID interface=LAN-VLAN priority=90 virtual-address=192.168.1.254/24 \
  adver-interval=1s authenticate=yes auth-password= # your password

# DMZ configuration using VLAN
/interface vlan
add name=DMZ-VLAN-RED vlan-id=20 interface=ether2
/interface vrrp
add name=DMZ-VRRP-RED vrid=$DMZ_VRID interface=DMZ-VLAN priority=90 virtual-address=192.168.2.254/24 \
  adver-interval=1s authenticate=yes auth-password= # your password

# Management configuration (Physical Interface)
/interface ethernet
add name=MGMT-RED ether3
/interface vrrp
add name=MGMT-VRRP vrid=$MGMT_VRID interface=MGMT priority=90 virtual-address=192.168.3.254/24 \
  adver-interval=1s authenticate=yes auth-password= # your password

# External configuration using VLAN 
/interface vlan
add name=external-VLAN-RED vlan-id=30 interface=ether4
/interface vrrp
add name=external-VRRP-RED vrid=$MGMT_VRID interface=external-VLAN priority=90 virtual-address=192.168.4.254/24 \
  adver-interval=1s authenticate=yes auth-password= # your password

# Firewall rules
/ip firewall filter
add chain=forward action=drop connection-state=invalid comment="Drop Invalid Connections"
add chain=forward action=accept connection-state=established,related comment="Accept Established/Related Connections"
add chain=forward action=accept in-interface=LAN-VLAN out-interface=DMZ-VLAN comment="Allow LAN to DMZ"
add chain=forward action=accept in-interface=DMZ-VLAN out-interface=external-VLAN comment="Allow DMZ to External"
add chain=forward action=drop comment="Drop Other Connections"

# NAT rules for DMZ
/ip firewall nat
add chain=srcnat action=masquerade out-interface=external-VLAN comment="NAT for DMZ Outbound Traffic"