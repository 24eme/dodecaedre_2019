#!/bin/bash

. bin/config.sh 2> /dev/null

if ! test "$CMD_CSV"; then
CMD_CSV="echo happy new year;happy 2019;";
fi

mkdir -p tmp generated

rm -f tmp/*

cat penta-cube-2019.svg | sed 's/id="impression" style="[^"]*"/id="impression" style="display: inline;"/' | sed 's/id="laser" style="[^"]*"/id="laser" style="display:none;"/' > tmp/penta-cube-2019_impression.svg
cat penta-cube-2019.svg | sed 's/id="impression" style="[^"]*"/id="impression" style="display: none;"/' | sed 's/id="laser" style="[^"]*"/id="laser" style="display: inline;"/' > tmp/penta-cube-2019_laser.svg

rm -f generated/*

inkscape tmp/penta-cube-2019_laser.svg --export-pdf=generated/penta-cube-2019_decoupe.pdf --without-gui=true

$CMD_CSV | sed 's/^*//' | awk -F ';' '{if ($2 && ! $5) print "sed \"s/HHHHHHHHHH/"$1"/\" tmp/penta-cube-2019_impression.svg | sed \"s/BBBBBBBBBB/"$2"/\" >  tmp/penta-cube-2019.svg ; inkscape tmp/penta-cube-2019.svg --export-pdf=generated/penta-cube-2019_"NR".pdf --without-gui=true"}'| sh

pdftk $(ls -rt generated/*) cat output penta-cube-2019.pdf
