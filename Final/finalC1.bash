link="http://localhost"

fullPage=$(curl -sL "$link")

toolOutput=$(echo "$fullPage" | \
sed '/<!DOCTYPE/d' | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --copy-of \
"//ul//li")

echo "$toolOutput" | sed 's/<\/li>/\n/g' | \
                     sed -e 's/&amp;//g' | \
                     sed -e 's/<li>//g' | \
                     sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
                     sed -e 's/<[/\]\{0,1\}nobr>//g' > IOC.txt
