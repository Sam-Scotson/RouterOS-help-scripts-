# Gamer FastTrack NAT Config
# MikroTik RouterOS version 6.x
# Replace <Destination_IP> with the appropriate IP addresses in each corresponding section.

# Enable Connection Tracking
/ip firewall connection tracking
set enabled=yes

# Enable FastTrack
/ip firewall filter
add action=fasttrack-connection chain=forward comment="FastTrack Established Connections" connection-state=established

# Enable Source Address Validation (Spoofing) Prevention (RP-Filter)
/interface ethernet set [find] rp-filter=strict

/ip firewall nat

# TCP Rule
add action=dst-nat chain=dstnat comment="TCP Ports" dst-port=53,80,88,443,500,6667,7777,1935,27015-27030,27036-27037,28015-28016,3074,3478-3480,5222,5223,6112,6113,8080,8888,9999,1119,12400,14000,14008,14020,14021,14022,14023,19305,24000,24100-24131,24300-24331,24500-24507,27014-27050,28014-28050,30016,30026,30031,30718,3478,3479,3480,50000-50003,54992-54994,55006-55007,55021-55040 protocol=tcp to-addresses=<Destination_IP> to-ports=53,80,88,443,500,6667,7777,1935,27015-27030,27036-27037,28015-28016,3074,3478-3480,5222,5223,6112,6113,8080,8888,9999,1119,12400,19305,24000,24100-24131,24300-24331,24500-24507,27014-27050,28014-28050,30016,30026,30031,30718,3478,3479,3480,50000-50003,54992-54994,55006-55007,55021-55040

# UDP Rule
add action=dst-nat chain=dstnat comment="UDP Ports" dst-port=1-65535 protocol=udp to-addresses=<Destination_IP>

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
