#!/bin/bash

log_file="/var/log/auth.log"

# Ensure running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Ensure UFW is installed
if ! command -v ufw &> /dev/null; then
  echo "UFW is not installed. Exiting."
  exit 1
fi

# Extract and count IPs from failed logins
matched_lines=$(awk '/[0-9]{2}:[0-9]{2}:[0-9]{2}.*Failed password.*[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ {
  match($0, /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/);
  print substr($0, RSTART, RLENGTH)
}' "$log_file")

ip_counts=$(echo "$matched_lines" | awk '{ count[$0]++ } END { for (ip in count) print ip, count[ip] }')

filtered_ip_addresses=$(echo "$ip_counts" | awk '$2 >= 10 { print $1 }')

echo "Blocking the following IP addresses with UFW:"

while read -r ip_address; do
  if ! sudo ufw status | grep -q "$ip_address"; then
    sudo ufw insert 1 deny from "$ip_address"
    echo "$ip_address"
  else
    echo "$ip_address already blocked"
  fi
done <<< "$filtered_ip_addresses"
