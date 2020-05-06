#!/bin/sh
ping –c 3 8.8.8.8 > /dev/null
if [ $? == 0 ]
then
  echo "funcionó correctamente"
else
  echo "no funcionó correctamente"
fi
