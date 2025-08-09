#!/bin/bash

# Script: check_uploads.sh
# Description: Runs inside the postiz container to check /uploads folder size & file count

CONTAINER_NAME="postiz"

docker exec "$CONTAINER_NAME" bash -c '
  find /uploads -type d | while read dir; do
    size_h=$(du -sh "$dir" 2>/dev/null | cut -f1)
    size_b=$(du -sb "$dir" 2>/dev/null | cut -f1)
    count=$(find "$dir" -type f | wc -l)
    # Use tab as separator to avoid spaces confusion
    printf "%s\t%s\t%d\t%d\n" "$dir" "$size_h" "$size_b" "$count"
  done | sort -t $'\t' -k3,3n | awk -F $'\t' '"'"'{printf "%-40s | %-8s | %d file(s)\n", $1, $2, $4}'"'"'
'
