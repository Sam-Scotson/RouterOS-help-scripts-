# Gamer FastTrack NAT Config
# MikroTik RouterOS version 6.x
# Replace <Wii_IP>, <Switch_IP>, <PS_IP>, <Xbox_IP>, and <Destination_IP> with the appropriate IP addresses in each corresponding section.

# Enable Connection Tracking
/ip firewall connection tracking
set enabled=yes

# Enable FastTrack
/ip firewall filter
add action=fasttrack-connection chain=forward comment="FastTrack Established Connections" connection-state=established

# Enable Source Address Validation (Spoofing) Prevention (RP-Filter)
/interface ethernet set [find] rp-filter=strict

# Nintendo Wii
/ip firewall nat
add action=dst-nat chain=dstnat comment="Nintendo Wii TCP" dst-port=443 protocol=tcp to-addresses=<Wii_IP> to-ports=443
add action=dst-nat chain=dstnat comment="Nintendo Wii UDP" dst-port=3074,3075 protocol=udp to-addresses=<Wii_IP> to-ports=3074-3075

# Nintendo Switch
add action=dst-nat chain=dstnat comment="Nintendo Switch TCP" dst-port=6667 protocol=tcp to-addresses=<Switch_IP> to-ports=6667
add action=dst-nat chain=dstnat comment="Nintendo Switch UDP" dst-port=12400,28910,29900,29901,29920 protocol=udp to-addresses=<Switch_IP> to-ports=12400,28910,29900,29901,29920

# Playstation 4 / 5
add action=dst-nat chain=dstnat comment="Playstation TCP" dst-port=80,3478,3480,5223 protocol=tcp to-addresses=<PS_IP> to-ports=80,3478,3480,5223
add action=dst-nat chain=dstnat comment="Playstation UDP" dst-port=3074,3478-3479,3658 protocol=udp to-addresses=<PS_IP> to-ports=3074,3478-3479,3658

# Xbox
add action=dst-nat chain=dstnat comment="Xbox TCP" dst-port=53,80,3074 protocol=tcp to-addresses=<Xbox_IP> to-ports=53,80,3074
add action=dst-nat chain=dstnat comment="Xbox UDP" dst-port=53,88,500,3074,22728,33233,3544,4500,17181-17183,17191-17390 protocol=udp to-addresses=<Xbox_IP> to-ports=53,88,500,3074,22728,33233,3544,4500,17181-17183,17191-17390

# Additional Ports
add action=dst-nat chain=dstnat comment="Source Engine" dst-port=27015 protocol=tcp to-addresses=<Destination_IP> to-ports=27015
add action=dst-nat chain=dstnat comment="Unreal Engine" dst-port=7777 protocol=tcp to-addresses=<Destination_IP> to-ports=7777
add action=dst-nat chain=dstnat comment="Minecraft" dst-port=25565 protocol=tcp to-addresses=<Destination_IP> to-ports=25565
add action=dst-nat chain=dstnat comment="Steam" dst-port=27015 protocol=tcp to-addresses=<Destination_IP> to-ports=27015

# Final Fantasy XV: Comrades 
add action=dst-nat chain=dstnat comment="Final Fantasy XV: Comrades - PS4 TCP" dst-port=1935,3478-3480,5223 protocol=tcp to-addresses=<Destination_IP> to-ports=1935,3478-3480,5223
add action=dst-nat chain=dstnat comment="Final Fantasy XV: Comrades - PS4 UDP" dst-port=3074,3478-3479,3658 protocol=udp to-addresses=<Destination_IP> to-ports=3074,3478-3479,3658 
add action=dst-nat chain=dstnat comment="Final Fantasy XV: Comrades - Steam TCP" dst-port=27015-27030,27036-27037 protocol=tcp to-addresses=<Destination_IP> to-ports=27015-27030,27036-27037
add action=dst-nat chain=dstnat comment="Final Fantasy XV: Comrades - Steam UDP" dst-port=4380,27000-27031,27036 protocol=udp to-addresses=<Destination_IP> to-ports=4380,27000-27031,27036
add action=dst-nat chain=dstnat comment="Final Fantasy XV: Comrades - Xbox One TCP" dst-port=3074 protocol=tcp to-addresses=<Destination_IP> to-ports=3074
add action=dst-nat chain=dstnat comment="Final Fantasy XV: Comrades - Xbox One UDP" dst-port=88,500,3074,3544,4500,17181-17183,17191-17390 protocol=udp to-addresses=<Destination_IP> to-ports=88,500,3074,3544,4500,17181-17183,17191-17390

# Final Fantasy XIV
add action=dst-nat chain=dstnat comment="Final Fantasy XIV TCP" dst-port=27015-27030,27036-27037,54992-54994,55006-55007,55021-55040 protocol=tcp to-addresses=<Destination_IP> to-ports=27015-27030,27036-27037,54992-54994,55006-55007,55021-55040
add action=dst-nat chain=dstnat comment="Final Fantasy XIV UDP" dst-port=4380,27000-27031,27036 protocol=udp to-addresses=<Destination_IP> to-ports=4380,27000-27031,27036

# Elden Ring
add action=dst-nat chain=dstnat comment="Elden Ring TCP" dst-port=27015,27036 protocol=tcp to-addresses=<Destination_IP> to-ports=27015,27036
add action=dst-nat chain=dstnat comment="Elden Ring UDP" dst-port=27015,27031-27036 protocol=udp to-addresses=<Destination_IP> to-ports=27015,27031-27036

# Tower of Fantasy - Steam
add action=dst-nat chain=dstnat comment="Tower of Fantasy - Steam TCP" dst-port=27015,27036,30016,30026,30031 protocol=tcp to-addresses=<Destination_IP> to-ports=27015,27036,30016,30026,30031
add action=dst-nat chain=dstnat comment="Tower of Fantasy - Steam UDP" dst-port=27015,27031-27036,30102,30150,30180,30194,30238 protocol=udp to-addresses=<Destination_IP> to-ports=27015,27031-27036,30102,30150,30180,30194,30238

# Conan Exiles
add action=dst-nat chain=dstnat comment="Conan Exiles Game Client" dst-port=7777 protocol=udp to-addresses=<Destination_IP> to-ports=7777

# Rust
add action=dst-nat chain=dstnat comment="Rust TCP" dst-port=28015-28016 protocol=tcp to-addresses=<Destination_IP> to-ports=28015-28016
add action=dst-nat chain=dstnat comment="Rust UDP" dst-port=28015-28016 protocol=udp to-addresses=<Destination_IP> to-ports=28015-28016

# Exoprimal
add action=dst-nat chain=dstnat comment="Exoprimal TCP" dst-port=80,443 protocol=tcp to-addresses=<Destination_IP> to-ports=80,443
add action=dst-nat chain=dstnat comment="Exoprimal UDP" dst-port=6174,7000-8000,12000-52000 protocol=udp to-addresses=<Destination_IP> to-ports=6174,7000-8000,12000-52000

# Elder Scrolls Online
add action=dst-nat chain=dstnat comment="Elder Scrolls Online TCP" dst-port=24100-24131,24500-24507,24300-24331,80,433 protocol=tcp to-addresses=<Destination_IP> to-ports=24100-24131,24500-24507,24300-24331,80,433
add action=dst-nat chain=dstnat comment="Elder Scrolls Online UDP" dst-port=24100-24131,24500-24507,24300-24331 protocol=udp to-addresses=<Destination_IP> to-ports=24100-24131,24500-24507,24300-24331

# Guild Wars 2
add action=dst-nat chain=dstnat comment="Guild Wars 2 TCP" dst-port=80,443,6112 protocol=tcp to-addresses=<Destination_IP> to-ports=80,443,6112

# Age of Empires
add action=dst-nat chain=dstnat comment="Age of Empires TCP" dst-port=8888,3478 protocol=tcp to-addresses=<Destination_IP> to-ports=8888,3478
add action=dst-nat chain=dstnat comment="Age of Empires UDP" dst-port=9999,3478 protocol=udp to-addresses=<Destination_IP> to-ports=9999,3478

# Dark Souls
add action=dst-nat chain=dstnat comment="Dark Souls TCP" dst-port=27015-27030,27036-27037 protocol=tcp to-addresses=<Destination_IP> to-ports=27015-27030,27036-27037
add action=dst-nat chain=dstnat comment="Dark Souls UDP" dst-port=4380,27000-27031,27036 protocol=udp to-addresses=<Destination_IP> to-ports=4380,27000-27031,27036

# Dark Souls 3
add action=dst-nat chain=dstnat comment="Dark Souls 3 TCP" dst-port=27014-27050,50050 protocol=tcp to-addresses=<Destination_IP> to-ports=27014-27050,50050
add action=dst-nat chain=dstnat comment="Dark Souls 3 UDP" dst-port=27000-27030,3478,4379,4380,50000-50003 protocol=udp to-addresses=<Destination_IP> to-ports=27000-27030,3478,4379,4380,50000-50003

# Naraka: Bladepoint
add action=dst-nat chain=dstnat comment="Naraka: Bladepoint TCP" dst-port=27015,27036,3478-3480,5222 protocol=tcp to-addresses=<Destination_IP> to-ports=27015,27036,3478-3480,5222
add action=dst-nat chain=dstnat comment="Naraka: Bladepoint UDP" dst-port=27015,27031-27036,5060,5062,6250 protocol=udp to-addresses=<Destination_IP> to-ports=27015,27031-27036,5060,5062,6250

# No Man's Sky
add action=dst-nat chain=dstnat comment="No Man's Sky - Steam TCP" dst-port=27015,27036 protocol=tcp to-addresses=<Destination_IP> to-ports=27015,27036
add action=dst-nat chain=dstnat comment="No Man's Sky - Steam UDP" dst-port=27015,27031-27036 protocol=udp to-addresses=<Destination_IP> to-ports=27015,27031-27036
add action=dst-nat chain=dstnat comment="No Man's Sky - PS4 TCP" dst-port=3478-3480 protocol=tcp to-addresses=<Destination_IP> to-ports=3478-3480
add action=dst-nat chain=dstnat comment="No Man's Sky - PS4 UDP" dst-port=3074,3478-3479 protocol=udp to-addresses=<Destination_IP> to-ports=3074,3478-3479
add action=dst-nat chain=dstnat comment="No Man's Sky - PS5 TCP" dst-port=3478-3480 protocol=tcp to-addresses=<Destination_IP> to-ports=3478-3480
add action=dst-nat chain=dstnat comment="No Man's Sky - PS5 UDP" dst-port=3074,3478-3479 protocol=udp to-addresses=<Destination_IP> to-ports=3074,3478-3479
add action=dst-nat chain=dstnat comment="No Man's Sky - Switch TCP" dst-port=6667,12400,28910,29900,29901,29920 protocol=tcp to-addresses=<Destination_IP> to-ports=6667,12400,28910,29900,29901,29920
add action=dst-nat chain=dstnat comment="No Man's Sky - Switch UDP" dst-port=1-65535 protocol=udp to-addresses=<Destination_IP>
add action=dst-nat chain=dstnat comment="No Man's Sky - Xbox One TCP" dst-port=3074 protocol=tcp to-addresses=<Destination_IP> to-ports=3074
add action=dst-nat chain=dstnat comment="No Man's Sky - Xbox One UDP" dst-port=88,500,3074,3544,4500 protocol=udp to-addresses=<Destination_IP> to-ports=88,500,3074,3544,4500
add action=dst-nat chain=dstnat comment="No Man's Sky - Xbox Series X TCP" dst-port=3074 protocol=tcp to-addresses=<Destination_IP> to-ports=3074
add action=dst-nat chain=dstnat comment="No Man's Sky - Xbox Series X UDP" dst-port=88,500,3074,3544,4500 protocol=udp to-addresses=<Destination_IP> to-ports=88,500,3074,3544,4500

# Overwatch 2
add action=dst-nat chain=dstnat comment="Overwatch 2 TCP" dst-port=1119,6113,80,443 protocol=tcp to-addresses=<Destination_IP> to-ports=1119,6113,80,443
add action=dst-nat chain=dstnat comment="Overwatch 2 UDP" dst-port=5060,5062,6250,3478,3479,3480 protocol=udp to-addresses=<Destination_IP> to-ports=5060,5062,6250,3478,3479,3480

# Final Fantasy XIV
add action=dst-nat chain=dstnat comment="Final Fantasy XIV TCP" dst-port=27015-27030,27036-27037,54992-54994,55006-55007,55021-55040 protocol=tcp to-addresses=<Destination_IP> to-ports=27015-27030,27036-27037,54992-54994,55006-55007,55021-55040
add action=dst-nat chain=dstnat comment="Final Fantasy XIV UDP" dst-port=4380,27000-27031,27036 protocol=udp to-addresses=<Destination_IP>

# Diablo 4 
add action=dst-nat chain=dstnat comment="Diablo 4 TCP" dst-port=3478-3480,1119,6112-6114,28890-28893,54545-54549 protocol=tcp to-addresses=<Destination_IP> to-ports=3478-3480,1119,6112-6114,28890-28893,54545-54549
add action=dst-nat chain=dstnat comment="Diablo 4 UDP" dst-port=1119,3074,3478-3479,6120 protocol=udp to-addresses=<Destination_IP>

# Destiny 2
add action=dst-nat chain=dstnat comment="Destiny 2 TCP" dst-port=3074 protocol=tcp to-addresses=<Destination_IP> to-ports=3074
add action=dst-nat chain=dstnat comment="Destiny 2 UDP" dst-port=88,500,3544,4500 protocol=udp to-addresses=<Destination_IP> to-ports=88,500,3544,4500

# World of Warcraft
add action=dst-nat chain=dstnat comment="World of Warcraft TCP" dst-port=1119,3724,6012 protocol=tcp to-addresses=<Destination_IP> to-ports=1119,3724,6012
add action=dst-nat chain=dstnat comment="World of Warcraft UDP" dst-port=1119,3724,6012 protocol=udp to-addresses=<Destination_IP> to-ports=1119,3724,6012

# Fortnite 
add action=dst-nat chain=dstnat comment="Fortnite TCP" dst-port=5222,5795-5847 protocol=tcp to-addresses=<Destination_IP> to-ports=5222,5795-5847
add action=dst-nat chain=dstnat comment="Fortnite UDP" dst-port=5222,5795-5847 protocol=udp to-addresses=<Destination_IP> to-ports=5222,5795-5847

# Craftopia 
add action=dst-nat chain=dstnat comment="Craftopia TCP" dst-port=27015,27036 protocol=tcp to-addresses=<Destination_IP> to-ports=27015,27036
add action=dst-nat chain=dstnat comment="Craftopia UDP" dst-port=6587,27015,27031-27036 protocol=udp to-addresses=<Destination_IP>

# Roblox
add action=dst-nat chain=dstnat comment="Roblox UDP" dst-port=49152-65535 protocol=udp to-addresses=<Destination_IP>

# Call of Duty: Modern Warfare 2
add action=dst-nat chain=dstnat comment="Call of Duty: Modern Warfare 2 TCP" dst-port=3074,27014-27050 protocol=tcp to-addresses=<Destination_IP> to-ports=3074,27014-27050
add action=dst-nat chain=dstnat comment="Call of Duty: Modern Warfare 2 UDP" dst-port=3478,4379-4380,27000-27031,27036 protocol=udp to-addresses=<Destination_IP> to-ports=3478,4379-4380,27000-27031,27036

# Counter-Strike: Global Offensive
add action=dst-nat chain=dstnat comment="Counter-Strike: Global Offensive TCP" dst-port=27015,27036 protocol=tcp to-addresses=<Destination_IP> to-ports=27015,27036
add action=dst-nat chain=dstnat comment="Counter-Strike: Global Offensive UDP" dst-port=27015,27020,27031-27036 protocol=udp to-addresses=<Destination_IP> to-ports=27015,27020,27031-27036

# BattleBit Remastered                   
add action=dst-nat chain=dstnat comment="BattleBit Remastered TCP" dst-port=27015,27036,29998 protocol=tcp to-addresses=<Destination_IP> to-ports=27015,27036,29998
add action=dst-nat chain=dstnat comment="BattleBit Remastered UDP" dst-port=27015,27031-27036,29998 protocol=udp to-addresses=<Destination_IP> to-ports=27015,27031-27036,29998

# Remnant II 
add action=dst-nat chain=dstnat comment="Remnant II TCP" dst-port=27015,27036 protocol=tcp to-addresses=<Destination_IP> to-ports=27015,27036
add action=dst-nat chain=dstnat comment="Remnant II UDP" dst-port=27015,27031-27036 protocol=udp to-addresses=<Destination_IP> to-ports=27015,27031-27036

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
