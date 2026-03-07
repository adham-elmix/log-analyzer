#!/bin/bash
log_file=log.txt
echo "top IPs :"
grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}" $log_file | sort | uniq -c | sort -nr 
echo "Number of unique IPs : $(grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}" $log_file | sort -u | wc -l )"
echo "Failed logins : $(grep "failed" $log_file | wc -l)"
echo "IPs suspected of Brute Force attempts (more than 3 failed logins):"
grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}" $log_file | sort | uniq -c | sort -nr | awk '$1>3 {print "ip :",$2," Number of attempts : " , $1}'