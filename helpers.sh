#!/bin/bash
# 2024-04-24 Rajesh Parab
#
# Helpers.sh for bash script
#

# 2024-04-24 #---Function to check if host is reachable----------------------
check_remote_host_reachable() {
  if ping -c 1 -W 1 "$remote_server_ip_address" &>/dev/null; then
    echo "Check Ok: Remote host ($remote_server_ip_address) is reachable"
    return 0
  else
    echo "Error: Remote host ($remote_server_ip_address) is not reachable"
    return 1
  fi
}
#EOF
