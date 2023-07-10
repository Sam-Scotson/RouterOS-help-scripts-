# RADIUS avec VPN Configuration Script

# OpenVPN 

# Step 1: Enable RADIUS
# Enables the RADIUS service on the RouterOS device.
# This allows the device to communicate with the RADIUS server.
/radius enable

# Step 2: Add RADIUS Server
# Configures the RADIUS server details.
# Replace <RADIUS_SERVER_IP> with the IP address of your RADIUS server.
# Replace <RADIUS_SECRET> with the shared secret used for communication between the RouterOS device and RADIUS server.
/radius add service=ppp address=<RADIUS_SERVER_IP> secret=<RADIUS_SECRET>

# Step 3: Configure User Authentication
# Sets the authentication method for user login to RADIUS.
# This ensures that user authentication requests are sent to the RADIUS server.
/ip hotspot set default-authentication=radius

# Step 4: Configure Accounting
# Sets the accounting method to RADIUS for tracking user sessions and usage.
# This sends accounting information to the RADIUS server for billing and reporting purposes.
/ip hotspot set default-accounting=radius

# Step 5: Add RADIUS Server as Authentication Method
# Specifies the RADIUS server as the authentication method for the hotspot service.
# This allows users to authenticate using their RADIUS credentials.
/ip hotspot profile set [find] use-radius=yes

# Step 6: Add RADIUS Server as Accounting Method
# Specifies the RADIUS server as the accounting method for the hotspot service.
# This sends accounting information to the RADIUS server for user session tracking.
/ip hotspot profile set [find] accounting=yes

# Step 7: Configure RADIUS Server Timeout
# Sets the timeout value for RADIUS server communication.
# Replace <TIMEOUT_VALUE> with the desired timeout value in milliseconds.
/radius set timeout=<TIMEOUT_VALUE>

# Step 8: Configure RADIUS Server Retries
# Sets the number of retries for RADIUS server communication.
# Replace <RETRIES_COUNT> with the desired number of retries.
/radius set retries=<RETRIES_COUNT>

# Step 9: Configure RADIUS Accounting Interval
# Sets the interval for sending accounting updates to the RADIUS server.
# Replace <ACCOUNTING_INTERVAL> with the desired interval value in minutes.
/radius set accounting-interval=<ACCOUNTING_INTERVAL>

# Step 10: Configure RADIUS Accounting Threshold
# Sets the threshold for sending accounting updates to the RADIUS server.
# Replace <ACCOUNTING_THRESHOLD> with the desired threshold value in bytes.
/radius set accounting-threshold=<ACCOUNTING_THRESHOLD>

# Step 11: Set RADIUS Server as PPP Authentication Method
# Specifies the RADIUS server as the authentication method for PPP connections.
# This allows users to authenticate using their RADIUS credentials for PPP-based services.
/ppp profile set default use-radius=yes

# Step 12: Enable OpenVPN Server
# Enables the OpenVPN server on the RouterOS device.
# This allows clients to establish OpenVPN connections.
/interface ovpn-server server set enabled=yes

# Step 13: Generate OpenVPN Certificates
# Generates the server certificate for OpenVPN.
# Replace <SERVER_COMMON_NAME> with the common name for the server certificate.
/certificate add name=server-cert common-name=<SERVER_COMMON_NAME> days-valid=3650 key-size=2048

# Step 14: Configure OpenVPN Profile
# Configures the OpenVPN profile and associates the server certificate with the default profile.
/ovpn-server profile add name=default user-profile=default certificate=server-cert

# Step 15: Set OpenVPN Server Certificate
# Sets the generated server certificate as the certificate for the OpenVPN server.
/interface ovpn-server server set certificate=server-cert

# Step 16: Set OpenVPN User Authentication
# Enables encryption for OpenVPN connections and associates the default OpenVPN profile with the PPP profile.
/ppp profile set default-encryption=yes ovpn-profile=default

# Step 17: Set OpenVPN User Authentication Method
# Sets encryption as the authentication method for OpenVPN connections.
/ppp profile set default use-encryption=yes

# Step 18: Add OpenVPN User
# Adds an OpenVPN user with the specified <USERNAME> and <PASSWORD>.
# This user will be able to authenticate and establish an OpenVPN connection.
# The authentication is handled by the RADIUS server, as configured in the previous steps.
/ppp secret add name=<USERNAME> password=<PASSWORD> service=ovpn profile=default

# Step 19: Set OpenVPN Encryption Algorithm
# Sets the encryption algorithm for OpenVPN connections.
# In this example, AES-256-CBC is used as the cipher.
# You can adjust this based on your specific security requirements.
/interface ovpn-server server set default-profile=default ovpn-option="cipher AES-256-CBC"

# Step 20: Set OpenVPN UDP Port (Optional)
# Sets the UDP port for OpenVPN.
# Replace <UDP_PORT> with the desired UDP port for OpenVPN.
# If not specified, the default port 1194 will be used.
/interface ovpn-server server set port=<UDP_PORT>

#////////////////////////////////////////////////////////////////////////////////////////////

# PPTP VPN 

# Step 1: Enable RADIUS
# Enables the RADIUS service on the RouterOS device.
# This allows the device to communicate with the RADIUS server.
/radius enable

# Step 2: Add RADIUS Server
# Configures the RADIUS server details.
# Replace <RADIUS_SERVER_IP> with the IP address of your RADIUS server.
# Replace <RADIUS_SECRET> with the shared secret used for communication between the RouterOS device and RADIUS server.
/radius add service=ppp address=<RADIUS_SERVER_IP> secret=<RADIUS_SECRET>

# Step 3: Configure User Authentication
# Sets the authentication method for user login to RADIUS.
# This ensures that user authentication requests are sent to the RADIUS server.
/ip hotspot set default-authentication=radius

# Step 4: Configure Accounting
# Sets the accounting method to RADIUS for tracking user sessions and usage.
# This sends accounting information to the RADIUS server for billing and reporting purposes.
/ip hotspot set default-accounting=radius

# Step 5: Add RADIUS Server as Authentication Method
# Specifies the RADIUS server as the authentication method for the hotspot service.
# This allows users to authenticate using their RADIUS credentials.
/ip hotspot profile set [find] use-radius=yes

# Step 6: Add RADIUS Server as Accounting Method
# Specifies the RADIUS server as the accounting method for the hotspot service.
# This sends accounting information to the RADIUS server for user session tracking.
/ip hotspot profile set [find] accounting=yes

# Step 7: Configure RADIUS Server Timeout
# Sets the timeout value for RADIUS server communication.
# Replace <TIMEOUT_VALUE> with the desired timeout value in milliseconds.
/radius set timeout=<TIMEOUT_VALUE>

# Step 8: Configure RADIUS Server Retries
# Sets the number of retries for RADIUS server communication.
# Replace <RETRIES_COUNT> with the desired number of retries.
/radius set retries=<RETRIES_COUNT>

# Step 9: Configure RADIUS Accounting Interval
# Sets the interval for sending accounting updates to the RADIUS server.
# Replace <ACCOUNTING_INTERVAL> with the desired interval value in minutes.
/radius set accounting-interval=<ACCOUNTING_INTERVAL>

# Step 10: Configure RADIUS Accounting Threshold
# Sets the threshold for sending accounting updates to the RADIUS server.
# Replace <ACCOUNTING_THRESHOLD> with the desired threshold value in bytes.
/radius set accounting-threshold=<ACCOUNTING_THRESHOLD>

# Step 11: Set RADIUS Server as PPP Authentication Method
# Specifies the RADIUS server as the authentication method for PPP connections.
# This allows users to authenticate using their RADIUS credentials for PPP-based services.
/ppp profile set default use-radius=yes

# Step 12: Enable PPTP Server
# Enables the PPTP server on the RouterOS device.
# This allows clients to establish PPTP VPN connections.
/interface pptp-server server set enabled=yes

# Step 13: Add PPTP User
# Adds a PPTP user with the specified <USERNAME> and <PASSWORD>.
# This user will be able to authenticate and establish a PPTP VPN connection.
/ppp secret add name=<USERNAME> password=<PASSWORD> service=pptp

# Step 14: Configure PPTP Encryption
# Enables encryption for PPTP VPN connections.
# This ensures secure communication between the client and the RouterOS device.
/ppp profile set default-encryption=yes