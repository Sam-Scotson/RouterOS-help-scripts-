# Configure LAN and WAN interfaces
/interface ethernet set [ find default-name=ether4 ] name=lan
/interface ethernet set [ find default-name=ether5 ] name=wan

# Create a bridge for LAN
/interface bridge add name=lan-bridge
/interface bridge port add bridge=lan-bridge interface=lan

# Configure WAN interface
/ip dhcp-client add interface=wan disabled=no

# Configure VLAN for guest network
/interface vlan
add name=guest-vlan vlan-id=100 interface=lan-bridge

# Configure DHCP server for LAN and VLAN
/ip pool
add name=lan-pool ranges=192.168.1.2-192.168.1.252
add name=guest-pool ranges=192.168.2.2-192.168.2.252

/ip dhcp-server
add name=lan-dhcp interface=lan-bridge address-pool=lan-pool disabled=no lease-time=1h
add name=guest-dhcp interface=guest-vlan address-pool=guest-pool disabled=no lease-time=1h

# Set up WLAN interface
/interface wireless set [ find default-name=wlan1 ] ssid=Staff-Network mode=ap-bridge
/interface wireless set [ find default-name=wlan1 ] security-profile=default

/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik

# Create Guest WLAN interface and VLAN
/interface wireless
set [ find default-name=wlan1 ] ssid=GuestNetwork mode=ap band=2ghz-g/n vlan-mode=use-tag vlan-id=100

# Enable Client Isolation
/interface wireless set [ find default-name=wlan1 ] wds-mode=dynamic-mesh wds-default-bridge=none

# Set Bandwidth Limiting to 200 Mbps
/queue simple
add name=guest-limit target=192.168.88.0/24 max-limit=200M/200M burst-limit=0/0 burst-threshold=0/0 burst-time=0s/0s

# Set Session Timeout to 1 hour
/ip hotspot profile
set [ find default=yes ] idle-timeout=1h

# Configure firewall rules

# DNS queries only to trusted DNS servers
/ip firewall filter
add chain=forward action=accept protocol=udp dst-port=53 src-address-list=trusted-devices comment="Allow DNS to trusted servers"

# Drop all other DNS queries
/ip firewall filter
add chain=forward action=drop protocol=udp dst-port=53 comment="Drop other DNS queries"

# Allow HTTPS traffic from guest network to WAN
/ip firewall filter
add chain=forward action=accept protocol=tcp dst-port=443 src-address-list=guest-network comment="Allow HTTPS from guest network"

# Rate limit ICMP packets 
/ip firewall filter
add chain=input action=limit protocol=icmp comment="Limit ICMP packets"

# Limit new connections per IP 
/ip firewall filter
add chain=input action=limit connection-state=new src-address-list=!trusted-devices \
    limit=50/5s comment="Limit new connections per IP"

# Drop invalid connections
/ip firewall filter
add chain=input action=drop connection-state=invalid comment="Drop invalid connections"

# Detect and drop port scans
/ip firewall filter
add chain=input action=add-src-to-address-list address-list=port-scanners \
    address-list-timeout=1w protocol=tcp psd=21,3s,3,1 comment="Port scan detection"

add chain=input action=drop src-address-list=port-scanners comment="Drop port scan traffic"

# DNS servers
/ip dns set servers=8.8.8.8,8.8.4.4

# QoS for Guest Network
/queue type
add kind=pcq name=guest-default pcq-classifier=dst-address pcq-rate=10M pcq-limit=50
/queue tree
add name=guest-qos parent=global priority=1 queue=default
add name=guest-queue parent=guest-qos packet-mark=guest-packet limit-at=9M max-limit=10M burst-limit=0 burst-threshold=0 burst-time=0s
/ip firewall mangle
add chain=forward src-address=192.168.88.0/24 action=mark-packet new-packet-mark=guest-packet passthrough=no