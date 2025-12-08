file="/home/Logan/csi230/Week14/fileaccesslog.txt"

echo "File was accessed" >> "$file"
date >> "$file"

mail -s "EMAIL" logan.donoghue@mymail.champlain.edu < "$file"
