#!/bin/bash

set -e

INPUT=$1
MASK=$2
OUTPUT=$3

for path in $INPUT; do
    folder=$(dirname "$path")
    filename=$(basename "$path")

    pattern="20[0-9]{2}\-[0-9]{2}\-[0-9]{2}\ .*"

    LANG=de_DE

    if [[ {$filename} =~ $pattern ]]; then

        
        outFile="$OUTPUT/$filename"

        if [ -f "${outFile}" ]; then
            echo "Skipping  $filename (existing)"
        else
            echo "Processing  $filename"
            IFS=' ' # space is set as delimiter
            read -ra dates <<< "$filename" # str is read into an array as tokens separated by IFS
    
            datum=`LC_ALL=de_DE.utf8 date -d "${dates[0]}" "+%d. %b %Y"`
    
            tempFile="/tmp/temp.jpg"
    
            convert "$path" -resize 1080x1080^ "${tempFile}"
            composite -geometry +50+50 "${tempFile}" $MASK "${tempFile}"
    
            composite -geometry +0+0 $MASK "${tempFile}" "${tempFile}"
    	convert "${tempFile}" -gravity center -font URW-Chancery-L-Medium-Italic -pointsize 60 -annotate -45x+430+430 "$datum" "${tempFile}"

            convert "${tempFile}" -gravity center -font URW-Chancery-L-Medium-Italic -pointsize 48 -annotate -45x-430-430 "try_to_cook_this" "${outFile}"
        fi

    else
        echo "Skipping  $filename (wrong pattern)"

    fi
done
