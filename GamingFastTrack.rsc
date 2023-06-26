# Enable FastTrack
/ip firewall filter
add action=fasttrack-connection chain=forward comment="FastTrack Established Connections" connection-state=established

# Nintendo Wii
/ip firewall nat
add action=dst-nat chain=dstnat comment="Nintendo Wii - TCP/443" dst-port=443 protocol=tcp to-addresses=<Wii_IP> to-ports=443
add action=dst-nat chain=dstnat comment="Nintendo Wii - UDP/3074, 3075" dst-port=3074,3075 protocol=udp to-addresses=<Wii_IP> to-ports=3074-3075

# Nintendo Switch
add action=dst-nat chain=dstnat comment="Nintendo Switch - TCP/6667" dst-port=6667 protocol=tcp to-addresses=<Switch_IP> to-ports=6667
add action=dst-nat chain=dstnat comment="Nintendo Switch - UDP/12400, 28910, 29900, 29901, 29920" dst-port=12400,28910,29900,29901,29920 protocol=udp to-addresses=<Switch_IP> to-ports=12400,28910,29900,29901,29920

# Playstation 4 / 5
add action=dst-nat chain=dstnat comment="Playstation 4 / 5 - TCP/80, 3478, 3479, 3480" dst-port=80,3478,3479,3480 protocol=tcp to-addresses=<PS_IP> to-ports=80,3478,3479,3480
add action=dst-nat chain=dstnat comment="Playstation 4 / 5 - UDP/3478, 3479, 3074, 3075" dst-port=3478,3479,3074,3075 protocol=udp to-addresses=<PS_IP> to-ports=3478,3479,3074,3075

# Xbox
add action=dst-nat chain=dstnat comment="Xbox - TCP/53, 80, 3074" dst-port=53,80,3074 protocol=tcp to-addresses=<Xbox_IP> to-ports=53,80,3074
add action=dst-nat chain=dstnat comment="Xbox - UDP/53, 88, 500, 3074, 22728, 33233, 3544, 4500" dst-port=53,88,500,3074,22728,33233,3544,4500 protocol=udp to-addresses=<Xbox_IP> to-ports=53,88,500,3074,22728,33233,3544,4500

# Additional Ports
add action=dst-nat chain=dstnat comment="Source - TCP/27015" dst-port=27015 protocol=tcp to-addresses=<Destination_IP> to-ports=27015
add action=dst-nat chain=dstnat comment="Unreal - TCP/7777" dst-port=7777 protocol=tcp to-addresses=<Destination_IP> to-ports=7777
add action=dst-nat chain=dstnat comment="Minecraft - TCP/25565" dst-port=25565 protocol=tcp to-addresses=<Destination_IP> to-ports=25565
add action=dst-nat chain=dstnat comment="Steam - TCP/27015" dst-port=27015 protocol=tcp to-addresses=<Destination_IP> to-ports=27015

# Common TCP Ports
add action=dst-nat chain=dstnat comment="Common TCP Ports" dst-port=14000,14008,14020,14021,14022,14023 protocol=tcp to-addresses=<Destination_IP>

# Common UDP Range
add action=dst-nat chain=dstnat comment="Common UDP Range" dst-port=1024-65535 protocol=udp to-addresses=<Destination_IP>