#!/bin/sh

for snapshot_id in $*
do
    echo "Delete snapshot $snapshot_id"
    curl -s -X DELETE "http://localhost:9200/_snapshot/ldgourmet_backup/$snapshot_id"
done
