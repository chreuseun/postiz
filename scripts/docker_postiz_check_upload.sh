#!/bin/bash

# Note!!!
# Incase sh check_uploads.sh does not work, run chmod +x check_uploads.sh
# This script is designed to run inside the `postiz` Docker container

# Script: check_uploads.sh
# Description: Runs inside the postiz container to check /uploads folder size & file count

CONTAINER_NAME="postiz"

docker exec "$CONTAINER_NAME" bash -c '
find /uploads -type d | while read dir; do
    # Human readable size
    size_h=$(du -sh "$dir" 2>/dev/null | cut -f1)
    # Size in bytes (for sorting)
    size_b=$(du -sb "$dir" 2>/dev/null | cut -f1)
    # File count
    count=$(find "$dir" -type f | wc -l)
    printf "%-40s | %-8s | %8d | %d\n" "$dir" "$size_h" "$size_b" "$count"
done | sort -t "|" -k3 -n |
awk -F "|" '"'"'{printf "%-40s | %-8s | %d file(s)\n", $1, $2, $4}'"'"'
'