#Set up for a MikroTik router in pppoe config for FWA system
#Replace '_____' with user inputs

/interface bridge
add name=bridge

/interface pppoe-client
add add-default-route=yes disabled=no interface=ether5 name=pppoe-out1 \
    password=______ use-peer-dns=yes user=____
#example--> password=XXXXX user=XXX.XXX.XXX.XXX (all octets need to be 3 digits)

/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-psk eap-methods="" management-protection=\
    allowed mode=dynamic-keys name=profile1 supplicant-identity="" \
    wpa2-pre-shared-key=____
#example--> wpa2-pre-shared-key=Passw0rd

/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n country="new zealand" \
    disabled=no mode=ap-bridge security-profile=profile1 ssid=____
# example--> ssid=XXXX (name for network)

/ip pool
add name=dhcp_pool0 ranges=____
#example--> ranges=XXX.XXX.XXX.1-XXX.XXX.XXX.253

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
#example--> address=XXX.XXX.XXX.254/24

/ip dhcp-server network
add address=____ gateway=_____
#example--> address=XXX.XXX.X.0/24 gateway=XXX.XXX.XXX.254

/ip dns
set servers=8.8.8.8, _____, ______
#add additional dns ip's

/system clock
set time-zone-name=______
#set system clock="your timezone"

/system identity
set name=_______
#set name=”Address” (ID for router)

/system ntp client
set enabled=yes primary-ntp=____ secondary-ntp=_____
#add desired ntp

/ip firewall nat
add action=masquerade chain=srcnat out-interface=pppoe-out1

/ip firewall address-list
add address=______ list=TRUSTED
#add desired trusted IP's

#simple firewall list for pppoe, add or subtract as needed, add ports
/ip firewall address-list
add address=xxx.xxx.xxx.xxx list=TRUSTED

/ip firewall filter
add action=accept chain=input connection-state=established,related
add action=accept chain=input src-address-list=TRUSTED
add action=accept chain=input protocol=icmp
add action=accept chain=input dst-address=255.255.255.255 dst-port=
protocol=udp
add action=accept chain=input dst-port= in-interface-list=!WAN
protocol=udp
add action=accept chain=input dst-port= in-interface-list=!WAN
protocol=tcp
add action=drop chain=input
