{
echo "<html>"
echo "<title> Report </title>"
echo "<body>"
echo "<table border='1'>"
echo "Access logs with IOC indicators"

while read -r -a line; do
	echo "<tr>"
	echo "<td> ${line[0]} </td>"
	echo "<td> ${line[2]} </td>"
	echo "<td> ${line[3]} </td>"
	echo "</tr>"
done < report.txt

echo "</table>"
echo "</body>"
echo "</html>"

} > "/var/www/html/report.html"
