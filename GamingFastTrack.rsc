# Gamer FastTrack NAT Config
# MikroTik RouterOS version 6.x
# Replace <Wii_IP>, <Switch_IP>, <PS_IP>, <Xbox_IP>, and <Destination_IP> with the appropriate IP addresses in each corresponding section.

# Enable Connection Tracking
/ip firewall connection tracking
set enabled=yes

# Enable FastTrack
/ip firewall filter
add action=fasttrack-connection chain=forward comment="FastTrack Established Connections" connection-state=established

# Nintendo Wii
/ip firewall nat
add action=dst-nat chain=dstnat comment="Nintendo Wii TCP" dst-port=443 protocol=tcp to-addresses=<Wii_IP> to-ports=443
add action=dst-nat chain=dstnat comment="Nintendo Wii UDP" dst-port=3074,3075 protocol=udp to-addresses=<Wii_IP> to-ports=3074-3075

# Nintendo Switch
add action=dst-nat chain=dstnat comment="Nintendo Switch TCP"  dst-port=6667 protocol=tcp to-addresses=<Switch_IP> to-ports=6667
add action=dst-nat chain=dstnat comment="Nintendo Switch UDP" dst-port=12400,28910,29900,29901,29920 protocol=udp to-addresses=<Switch_IP> to-ports=12400,28910,29900,29901,29920

# Playstation 4 / 5
add action=dst-nat chain=dstnat comment="Playstation TCP" dst-port=80,3478,3479,3480 protocol=tcp to-addresses=<PS_IP> to-ports=80,3478,3479,3480
add action=dst-nat chain=dstnat comment="Playstation UDP" dst-port=3478,3479,3074,3075 protocol=udp to-addresses=<PS_IP> to-ports=3478,3479,3074,3075

# Xbox
add action=dst-nat chain=dstnat comment="Xbox TCP" dst-port=53,80,3074 protocol=tcp to-addresses=<Xbox_IP> to-ports=53,80,3074
add action=dst-nat chain=dstnat comment="Xbox UDP" dst-port=53,88,500,3074,22728,33233,3544,4500 protocol=udp to-addresses=<Xbox_IP> to-ports=53,88,500,3074,22728,33233,3544,4500

# Additional Ports
add action=dst-nat chain=dstnat comment="Source Engine" dst-port=27015 protocol=tcp to-addresses=<Destination_IP> to-ports=27015
add action=dst-nat chain=dstnat comment="Unreal Engine" dst-port=7777 protocol=tcp to-addresses=<Destination_IP> to-ports=7777
add action=dst-nat chain=dstnat comment="Minecraft" dst-port=25565 protocol=tcp to-addresses=<Destination_IP> to-ports=25565
add action=dst-nat chain=dstnat comment="Steam" dst-port=27015 protocol=tcp to-addresses=<Destination_IP> to-ports=27015
add action=dst-nat chain=dstnat comment="Final Fantasy XIV" dst-port=32300-32303 protocol=tcp to-addresses=<Destination_IP> to-ports=32300-32303
add action=dst-nat chain=dstnat comment="Riot Games UDP" dst-port=5000-5500 protocol=udp to-addresses=<Destination_IP>
add action=dst-nat chain=dstnat comment="Riot Games TCP" dst-port=8393-8400,2099,5223,5222 protocol=tcp to-addresses=<Destination_IP>
add action=dst-nat chain=dstnat comment="Tibia TCP" dst-port=7171 protocol=tcp to-addresses=<Destination_IP> to-ports=7171
add action=dst-nat chain=dstnat comment="Tibia UDP" dst-port=7171 protocol=udp to-addresses=<Destination_IP> to-ports=7171
add action=dst-nat chain=dstnat comment="Fortnite TCP" dst-port=3478,3479,5060,5062,5222,6250 protocol=tcp to-addresses=<Destination_IP> to-ports=3478,3479,5060,5062,5222,6250
add action=dst-nat chain=dstnat comment="Fortnite UDP" dst-port=3478,3479,5060,5062,5222,6250 protocol=udp to-addresses=<Destination_IP> to-ports=3478,3479,5060,5062,5222,6250

# Common TCP Ports
add action=dst-nat chain=dstnat comment="Common TCP Ports" dst-port=14000,14008,14020,14021,14022,14023 protocol=tcp to-addresses=<Destination_IP>

# Common UDP Range
add action=dst-nat chain=dstnat comment="Common UDP Range" dst-port=1024-65535 protocol=udp to-addresses=<Destination_IP>

# Enable DoS/DDoS Protection
/ip firewall filter
add action=accept chain=input comment="Accept Established Connections" connection-state=established
add action=accept chain=input comment="Accept Related Connections" connection-state=related
add action=drop chain=input comment="Drop Invalid Connections" connection-state=invalid
add action=accept chain=input comment="Accept ICMP" protocol=icmp
add action=accept chain=input comment="Accept DNS" dst-port=53 protocol=udp
add action=accept chain=input comment="Accept NTP" dst-port=123 protocol=udp
add action=accept chain=input comment="Accept SSH" dst-port=22 protocol=tcp
add action=accept chain=input comment="Accept Winbox" dst-port=8291 protocol=tcp
add action=accept chain=input comment="Accept HTTP" dst-port=80 protocol=tcp
add action=accept chain=input comment="Accept HTTPS" dst-port=443 protocol=tcp
add action=drop chain=input comment="Drop All Remaining" 

# Enable SYN Flood Protection
/ip firewall filter
add action=drop chain=input comment="Drop SYN Flood" protocol=tcp tcp-flags=syn connection-limit=30,32

# Enable Port Knocking
/ip firewall filter
add action=add-src-to-address-list address-list="portknock" address-list-timeout=10s chain=input comment="Port Knocking - Stage 1" dst-port=1234 protocol=udp
add action=add-src-to-address-list address-list="portknock" address-list-timeout=10s chain=input comment="Port Knocking - Stage 2" dst-port=5678 protocol=udp
add action=add-src-to-address-list address-list="portknock" address-list-timeout=10s chain=input comment="Port Knocking - Stage 3" dst-port=9012 protocol=udp
add action=drop chain=input comment="Drop Invalid Port Knocking" connection-state=new src-address-list=!portknock

# Update RouterOS:
# Remove # to activate 
#/system package update check-for-updates
