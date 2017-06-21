#!/bin/bash

countzero=0
let "countzero++"
  while [ 1 ]
  do
    echo -n "dummy #$countzero -"
    let "countzero++"
    date
    sleep 5
  done
