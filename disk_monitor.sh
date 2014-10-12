#!/usr/bin/env bash

set -e

# Monitor the disk space
df -H | grep -vE '^Filesystem|tmps|cdrom|檔案系統' | awk '{ print $5 " " $ 1}' | while read output;
do
    disk_use=$(echo $output | awk '{ print $1}' | cut -d '%' -f1)
    partition=$(echo $output | awk '{ print $2}')

    if [ $disk_use -ge 85 ]; then
        echo "Running out of disk space \"$partition (${disk_use}%)\" on $(hostname) as on $(date)"
    fi
done


