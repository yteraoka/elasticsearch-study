#!/bin/sh

snapshot_id=$1
prefix=$2

if [ "$prefix" = "" ] ; then
    curl -s -X POST "http://localhost:9200/_snapshot/ldgourmet_backup/$snapshot_id/_restore" -d '{
  "indices": "ldgourmet"
}'
else
    curl -s -X POST "http://localhost:9200/_snapshot/ldgourmet_backup/$snapshot_id/_restore" -d "{
  \"indices\": \"ldgourmet\",
  \"rename_pattern\": \"(.+)\",
  \"rename_replacement\": \"${prefix}_\$1\"
}"
fi
