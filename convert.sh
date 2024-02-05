#!/bin/bash
# Usage: ./convert.sh

rm -rf PNGs
rm -rf BMPs
mkdir "./PNGs"
mkdir "./BMPs"

for file in *.psd; do
    if [ -f "$file" ]; then
        filename=$(basename -- "$file")
        extension="${filename##*.}"
        filename="${filename%.*}"
		
		# convert every PSD into a PNG
		./magick.exe convert "$filename.psd[0]" "./PNGs/$filename.png"
		
		# crop the transparent pixels
		./magick.exe mogrify -trim +repage "./PNGs/$filename.png"
		echo "generated ./PNGs/$filename.png"
		
		# convert each PNG into a BMP for Arduino
		./magick.exe convert "./PNGs/$filename.png" -type truecolor "./BMPs/$filename.bmp"
		echo "generated ./BMPs/$filename.bmp"
    fi
done