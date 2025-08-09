#!/bin/bash

CONTAINER_NAME="postiz"

docker exec "$CONTAINER_NAME" bash -c '
  find /uploads -type d | while read dir; do
    size_h=$(du -sh "$dir" 2>/dev/null | cut -f1)
    size_b=$(du -sb "$dir" 2>/dev/null | cut -f1)
    count=$(find "$dir" -type f | wc -l)
    # use pipe | as separator without spaces
    printf "%s|%s|%d|%d\n" "$dir" "$size_h" "$size_b" "$count"
  done | sort -t"|" -k3,3n | awk -F"|" '\''{printf "%-40s | %-8s | %d file(s)\n", $1, $2, $4}'\''
'
