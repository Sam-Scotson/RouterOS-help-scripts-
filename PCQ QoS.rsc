# PCQ QoS
# Set queue types for customers

# Basic Package
/queue type
add name="basic_upload" kind=pcq pcq-src-address-mask=32 pcq-src-addresses=0.0.0.0/0 pcq-dst-address-mask=0 pcq-dst-addresses=0.0.0.0/0 comment="PCQ for Basic Package Upload"
add name="basic_download" kind=pcq pcq-src-address-mask=0 pcq-src-addresses=0.0.0.0/0 pcq-dst-address-mask=32 pcq-dst-addresses=0.0.0.0/0 comment="PCQ for Basic Package Download"

# Standard Package
add name="standard_upload" kind=pcq pcq-src-address-mask=32 pcq-src-addresses=0.0.0.0/0 pcq-dst-address-mask=0 pcq-dst-addresses=0.0.0.0/0 comment="PCQ for Standard Package Upload"
add name="standard_download" kind=pcq pcq-src-address-mask=0 pcq-src-addresses=0.0.0.0/0 pcq-dst-address-mask=32 pcq-dst-addresses=0.0.0.0/0 comment="PCQ for Standard Package Download"

# Premium Package
add name="premium_upload" kind=pcq pcq-src-address-mask=32 pcq-src-addresses=0.0.0.0/0 pcq-dst-address-mask=0 pcq-dst-addresses=0.0.0.0/0 comment="PCQ for Premium Package Upload"
add name="premium_download" kind=pcq pcq-src-address-mask=0 pcq-src-addresses=0.0.0.0/0 pcq-dst-address-mask=32 pcq-dst-addresses=0.0.0.0/0 comment="PCQ for Premium Package Download"

# Placeholder rate settings - adjust based on available bandwidth
/queue type
set [find name="basic_upload"] max-limit=10M/10M
set [find name="basic_download"] max-limit=80M/80M

set [find name="standard_upload"] max-limit=20M/20M
set [find name="standard_download"] max-limit=160M/160M

set [find name="premium_upload"] max-limit=30M/30M
set [find name="premium_download"] max-limit=240M/240M

# Create simple queues for bandwidth package
# Example
#//////////////////////
# Basic Package
/queue simple
add name="BasicPackage" target=192.168.1.0/24 max-limit=10M/20M queue-type-upload="basic_upload" queue-type-download="basic_download" comment="Simple queue for Basic Package"

# Standard Package
add name="StandardPackage" target=192.168.2.0/24 max-limit=20M/40M queue-type-upload="standard_upload" queue-type-download="standard_download" comment="Simple queue for Standard Package"

# Premium Package
add name="PremiumPackage" target=192.168.3.0/24 max-limit=30M/60M queue-type-upload="premium_upload" queue-type-download="premium_download" comment="Simple queue for Premium Package"
#//////////////////////

# Create mangle rules to classify traffic based on IP addresses or subnets

# Basic Package
/ip firewall mangle
add chain=prerouting src-address=192.168.1.0/25 action=mark-packet new-packet-mark=basic comment="Mark packets for Basic Package"

# Standard Package
add chain=prerouting src-address=192.168.1.128/25 action=mark-packet new-packet-mark=standard comment="Mark packets for Standard Package"

# Premium Package
add chain=prerouting src-address=192.168.1.192/26 action=mark-packet new-packet-mark=premium comment="Mark packets for Premium Package"

# Adjust the total limit setting based on the number of anticipated users
# Calculation: Total Limit = Number of Users * Default Limit
# Example: For 250 users, Total Limit = 250 * 50 = 12500

/queue type
set total-limit=12500
