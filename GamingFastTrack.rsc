# Replace <Wii_IP>, <Switch_IP>, <PS_IP>, <Xbox_IP>, and <Destination_IP> with the appropriate IP addresses in each corresponding section.

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

# Common TCP Ports
add action=dst-nat chain=dstnat comment="Common TCP Ports" dst-port=14000,14008,14020,14021,14022,14023 protocol=tcp to-addresses=<Destination_IP>

# Common UDP Range
add action=dst-nat chain=dstnat comment="Common UDP Range" dst-port=1024-65535 protocol=udp to-addresses=<Destination_IP>
