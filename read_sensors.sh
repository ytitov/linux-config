IFS=':'
count=0
sensors -u nct6779-isa-0290 |
  grep --no-group-separator input -B1 |
  while read line; do
    echo "match: $count : $line"
    arrIN=($line)
    idx=0
    for i in $line; do
      echo "  $idx   $i"
      ((idx++))
    done
    idx=0
    echo "arrin: $line"
    ((count++))
    if [ $count -eq 2 ]
    then ((count=0))
    fi
  done 

