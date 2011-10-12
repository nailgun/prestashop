#!/bin/bash

function optimize_png() {
    pngcrush="pngcrush -rem gAMA -rem cHRM -rem iCCP -rem sRGB -rem tEXt -l 9 -reduce"
    optipng="optipng -o7"

    $pngcrush $1 tmp.png && mv -f tmp.png $1
    $optipng $1
}

function optimize_jpeg() {
    jpegtran -optimize $1 > tmp.png && mv -f tmp.png $1
}

find $1 | while read filename; do
    type=$(file -b --mime-type $filename)
    if [ $type = 'image/png' ]; then
        optimize_png $filename
    fi
    if [ $type = 'image/jpeg' ]; then
        optimize_jpeg $filename
    fi
done
