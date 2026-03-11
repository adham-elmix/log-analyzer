#!/bin/bash
log_file="log.txt"
echo "Top IPs:"
grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}" "$log_file" | sort | uniq -c | sort -nr
echo "Failed logins:"
grep "failed" "$log_file" | wc -l
echo "Unique IPs:"
grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}" "$log_file"  | sort -u | wc -l
echo "IPs suspected of Brute Force attempts (more than 3 failed logins):\n$(grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}" "$log_file" | sort | uniq -c | sort -nr | awk '$1>3 {print "IP:", $2, "Attempts:", $1}')"
