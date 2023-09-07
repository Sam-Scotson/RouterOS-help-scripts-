# Change TX power mode to "card rates" on wlan1
/interface wireless set wlan1 tx-power-mode=card-rates

# Set the regulatory domain to Canada (Highest EIPR limit)
/interface wireless set wlan1 country=canada

# Set the antenna gain  (adjust as needed)
/interface wireless set wlan1 antenna-gain=6

# Set channel width to "20/40MHz XX"
/interface wireless set wlan1 channel-width=20/40mhz-XX

# Enable AMPDU priorities 0 to 5 on wlan1
/interface wireless set wlan1 ampdu-priorities=0,1,2,3,4,5

# Set HT Basic MCS from mcs-0-23
/interface wireless set wlan1 ht-basic-mcs=mcs-0,mcs-1,mcs-2,mcs-3,mcs-4,mcs-5,mcs-6,mcs-7,mcs-8,mcs-9,mcs-10,mcs-11,mcs-12,mcs-13,mcs-14,mcs-15,mcs-16,mcs-17,mcs-18,mcs-19,mcs-20,mcs-21,mcs-22,mcs-23

# Save the configuration changes
/system reboot
