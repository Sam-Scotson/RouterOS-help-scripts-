# Office 1 Configuration

# Create EoIP tunnel interface on Office 1 router
/interface eoip
add name=eoip-local remote-address="INSERT IP 1" tunnel-id=1

# Configure IP addresses for the EoIP tunnel interface
/ip address
add address=192.168.1.1/24 interface=eoip-local

# Create a user for EoIP tunnel authentication
/user group
add name=eoiptunnel
/user
add name="INSERT USERNAME 1" group=eoiptunnel password="INSERT PASSWORD 1"

# Configure firewall rules to allow EoIP traffic
/ip firewall filter
add action=accept chain=input comment="Allow EoIP" dst-port=97 protocol=udp
add action=accept chain=input comment="Allow EoIP" dst-port=50,51 protocol=udp
add action=accept chain=forward comment="Allow EoIP" protocol=eoip

#-------------------------------------------------------------------------------------------------

# Office 2 Configuration

# Create EoIP tunnel interface on Office 2 router
/interface eoip
add name=eoip-remote remote-address="INSERT IP 2" tunnel-id=1

# Configure IP addresses for the EoIP tunnel interface
/ip address
add address=192.168.1.2/24 interface=eoip-remote

# Create a user for EoIP tunnel authentication
/user group
add name=eoiptunnel
/user
add name="INSERT USERNAME 2" group=eoiptunnel password="INSERT PASSWORD 2"

# Configure firewall rules to allow EoIP traffic
/ip firewall filter
add action=accept chain=input comment="Allow EoIP" dst-port=97 protocol=udp
add action=accept chain=input comment="Allow EoIP" dst-port=50,51 protocol=udp
add action=accept chain=forward comment="Allow EoIP" protocol=eoip