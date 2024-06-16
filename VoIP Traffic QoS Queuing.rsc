# VoIP Traffic QoS Queuing

# Rule 1: Mark connections coming FROM the VoIP gateway
/add chain=prerouting src-address=xxx.xxx.xxx.xxx action=mark-connection new-connection-mark=VoIP_conn;

# Rule 2: Mark connections going TO the VoIP gateway
/add chain=prerouting dst-address=xxx.xxx.xxx.xxx action=mark-connection new-connection-mark=VoIP_conn;

# Rule 3: Mark actual VoIP packets based on the connection mark
/add chain=prerouting connection-mark=VoIP_conn action=mark-packet new-packet-mark=VoIP_packet passthrough=no;

# Queues for Bandwidth Management
# Note: Each concurrent VoIP call requires approximately 100 Kbps of upload and 100 Kbps of download bandwidth.
# Allocating 1 Mbps for VoIP should cover around 10 concurrent calls (considering overheads).
# Adjust the bandwidth allocation according to the expected number of concurrent calls.

# Queue 1: Prioritized VoIP Traffic
/queue simple
add name="VoIP Traffic" target=0.0.0.0/0 packet-mark=VoIP_packet max-limit=1M/1M priority=1;

# Queue 2: All Other Traffic
add name="All Other Traffic" target=0.0.0.0/0 packet-mark=no-mark max-limit=99M/99M priority=2;