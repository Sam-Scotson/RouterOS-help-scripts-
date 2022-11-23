#Set up for a MikroTik router in pppoe config for FWA system
#Replace '_____' with user inputs

/interface bridge
add name=bridge

/interface pppoe-client
add add-default-route=yes disabled=no interface=ether5 name=pppoe-out1 \
    password= use-peer-dns=yes user=____
#example--> password=XXXXX use-peer-dns=yes user=XXX.XXX.XXX.XXX (all octets need to be 3 digits)

/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-psk eap-methods="" management-protection=\
    allowed mode=dynamic-keys name=profile1 supplicant-identity="" \
    wpa2-pre-shared-key=____
#example--> wpa2-pre-shared-key=Passw0rd

/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n country="new zealand" \
    disabled=no mode=ap-bridge security-profile=profile1 ssid=____
# example--> disabled=no mode=ap-bridge security-profile=profile1 ssid=XXX.WiFi (Number Address)

/ip pool
add name=dhcp_pool0 ranges=____
#example--> add name=dhcp_pool0 ranges=XXX.XXX.XXX.1-XXX.XXX.XXX.253

/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=bridge lease-time=1w name=dhcp1

/interface bridge port
add bridge=bridge interface=ether1
add bridge=bridge interface=ether2
add bridge=bridge interface=ether3
add bridge=bridge interface=ether4
add bridge=bridge interface=wlan1

/ip address
add address=_____ interface=bridge
#example--> add address=XXX.XXX.XXX.254/24 interface=bridge

/ip dhcp-server network
add address=____ gateway=_____
#example--> add address=XXX.XXX.X.0/24 gateway=XXX.XXX.XXX.254

/ip dns
set servers=1.1.1.1, _____
#add additional dns ip's

/system clock
set time-zone-name=
#set system clock="timezone"

/system identity
set name=”_______”
#set name=”Address”

/system ntp client
set enabled=yes primary-ntp=____ secondary-ntp=_____
#add desired ntp

/ip firewall nat
add action=masquerade chain=srcnat out-interface=pppoe-out1

/ip firewall address-list
add address=______ list=TRUSTED
#add desired trusted IP's

/ip firewall filter
#simple firewall list for pppoe, add or subtract as needed
add action=accept chain=forward comment="Allow - TRUSTED" in-interface=\
    pppoe-out1 src-address-list=TRUSTED
add action=accept chain=forward comment="Allow - Established/Related" \
    connection-state=established,related in-interface=pppoe-out1
add action=drop chain=forward comment="Drop - Everything" in-interface=\
    pppoe-out1
add action=accept chain=input comment="Allow - PING" protocol=icmp
add action=accept chain=input comment="Allow - Neighbour Discovery" dst-port=\
    5678 protocol=udp
add action=accept chain=input comment="Allow - TRUSTED" src-address-list=\
    TRUSTED
add action=accept chain=input comment="Allow - Related/Established" \
    connection-state=established,related
add action=drop chain=input comment="Drop - Everything"
