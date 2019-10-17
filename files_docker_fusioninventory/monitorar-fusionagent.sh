#!/bin/bash

while ps aux | grep -v grep | grep 'fusioninventory-agent' >/dev/null 
do
    echo "SERVICE is running"
    sleep 20
done

echo "SERVICE stopped"
exit(1) 

