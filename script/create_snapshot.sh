#!/bin/sh
echo "Creating snapshot"
curl -s -X PUT "http://localhost:9200/_snapshot/ldgourmet_backup/$(date +%Y%m%d%H%M%S)?wait_for_completion=true&pretty" -d '{
  "indices": "ldgourmet"
}'
