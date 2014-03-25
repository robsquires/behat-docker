#!/bin/bash
 
features=$(find features -type f -name "*.feature")
 
max=10
ii=1
 
for i in $features
do
  echo "$ii,$i,end"
  if [ "$ii" -eq "$max" ]; then
   ii=1
  else
   let ii++
  fi
done