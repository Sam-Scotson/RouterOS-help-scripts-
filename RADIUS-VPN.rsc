# RADIUS avec VPN Configuration Script

# OpenVPN 

/radius enable

# Replace <RADIUS_SERVER_IP> with the IP address of your RADIUS server.
/radius add service=ppp address=<RADIUS_SERVER_IP> secret=<RADIUS_SECRET>

/ip hotspot set default-authentication=radius

/ip hotspot set default-accounting=radius

/ip hotspot profile set [find] use-radius=yes

/ip hotspot profile set [find] accounting=yes

# Replace <TIMEOUT_VALUE> with the desired timeout value in milliseconds.
/radius set timeout=<TIMEOUT_VALUE>

# Replace <RETRIES_COUNT> with the desired number of retries.
/radius set retries=<RETRIES_COUNT>

# Replace <ACCOUNTING_INTERVAL> with the desired interval value in minutes.
/radius set accounting-interval=<ACCOUNTING_INTERVAL>

# Replace <ACCOUNTING_THRESHOLD> with the desired threshold value in bytes.
/radius set accounting-threshold=<ACCOUNTING_THRESHOLD>

/ppp profile set default use-radius=yes

/interface ovpn-server server set enabled=yes

# Replace <SERVER_COMMON_NAME> with the common name for the server certificate.
/certificate add name=server-cert common-name=<SERVER_COMMON_NAME> days-valid=3650 key-size=2048

/ovpn-server profile add name=default user-profile=default certificate=server-cert

/interface ovpn-server server set certificate=server-cert

/ppp profile set default-encryption=yes ovpn-profile=default

/ppp profile set default use-encryption=yes

# Adds an OpenVPN user with the specified <USERNAME> and <PASSWORD>.
/ppp secret add name=<USERNAME> password=<PASSWORD> service=ovpn profile=default

/interface ovpn-server server set default-profile=default ovpn-option="cipher AES-256-CBC"

# Replace <UDP_PORT> with the desired UDP port for OpenVPN.
/interface ovpn-server server set port=<UDP_PORT>

#////////////////////////////////////////////////////////////////////////////////////////////

# PPTP VPN 

/radius enable

# Replace <RADIUS_SERVER_IP> with the IP address of your RADIUS server.
# Replace <RADIUS_SECRET> with the shared secret used for communication between the RouterOS device and RADIUS server.
/radius add service=ppp address=<RADIUS_SERVER_IP> secret=<RADIUS_SECRET>

/ip hotspot set default-authentication=radius

/ip hotspot set default-accounting=radius

/ip hotspot profile set [find] use-radius=yes

/ip hotspot profile set [find] accounting=yes

# Replace <TIMEOUT_VALUE> with the desired timeout value in milliseconds.
/radius set timeout=<TIMEOUT_VALUE>

# Replace <RETRIES_COUNT> with the desired number of retries.
/radius set retries=<RETRIES_COUNT>

# Replace <ACCOUNTING_INTERVAL> with the desired interval value in minutes.
/radius set accounting-interval=<ACCOUNTING_INTERVAL>

# Replace <ACCOUNTING_THRESHOLD> with the desired threshold value in bytes.
/radius set accounting-threshold=<ACCOUNTING_THRESHOLD>

/ppp profile set default use-radius=yes

/interface pptp-server server set enabled=yes

# Adds a PPTP user with the specified <USERNAME> and <PASSWORD>.
/ppp secret add name=<USERNAME> password=<PASSWORD> service=pptp

/ppp profile set default-encryption=yes
