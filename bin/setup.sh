#!/bin/sh

for f in config/*.example
do
  new_filename="${f%.*}"
  cp -f $f $new_filename
done