#!/bin/bash
log_file="log.txt"

if [ ! -f "$log_file" ]; then
  echo "log file does not exist!"
exit 1
fi

extract_ips() {
grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}" $log_file
}

show_top_ips() {
  echo "Top IPs:"
  extract_ips "$log_file" | sort | uniq -c | sort -nr
}

show_unique_ips_count() {
  echo "Unique IPs : $(extract_ips "$log_file" | sort -u | wc -l)"
}

show_failed_logins_count() {
  echo "Failed logins: $(grep -i "failed" "$log_file" | wc -l)"
}

show_brute_force_ips() {
  echo "IPs suspected of Brute Force attempts (more than 3 failed logins):"
  extract_ips "$log_file" | sort | uniq -c | sort -nr | awk '$1>3 {print "ip :",$2," Number of attempts : " , $1}'
}

show_top_ips
show_unique_ips_count
show_failed_logins_count
show_brute_force_ips