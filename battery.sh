#!/bin/bash

word=`acpi -b | grep -oE Discharging`

if [ ! $word ] ; then
  echo -n \#\[fg=yellow,bold\]
else
  echo -n \#\[fg=green,bold\]
fi

echo `acpi -b | grep -oE \[0-9\]+%`
