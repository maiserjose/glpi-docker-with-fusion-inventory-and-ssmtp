#!/bin/bash

fusioninventory-agent -d > /dev/stdout

while ps aux | grep -v grep | grep 'fusioninventory-agent' >/dev/null 
do
    echo "SERVICE is running"
    sleep 60
done

echo "fusioninventory-agent stopped" > /dev/stderr
exit 1