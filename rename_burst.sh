# script to rename an image burts
# takes the new name

count=1
name=$1
regex=^Image.*\.jpg

for file in $( ls . ); do
  if [[ "$file" =~ $regex ]]; then
    mv $file "$name$count.jpg"
    count=$(($count+1))
  fi
done
