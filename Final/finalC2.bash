sed 's/^[[:space:]]*//;s/[[:space:]]*$//' IOC.txt | grep -v '^$' | grep -F -f - "access.log" | cut -d " " -f 1,2,4,7 | sort > report.txt
