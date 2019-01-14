#!/bin/bash

. bin/config.sh 2> /dev/null

if ! test "$CMD_CSV"; then
CMD_CSV="echo happy new year;happy 2019;";
fi

mkdir -p tmp generated

 $CMD_CSV | sed 's/^*//' | awk -F ';' '{if ($2 && ! $5) print "sed \"s/HHHHHHHHHH/"$1"/\" penta-cube-2019.svg | sed \"s/BBBBBBBBBB/"$2"/\" >  tmp/penta-cube-2019.svg ; inkscape tmp/penta-cube-2019.svg --export-pdf=generated/penta-cube-2019_"NR".pdf --without-gui=true"}' #| sh
