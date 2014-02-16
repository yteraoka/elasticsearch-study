#!/bin/sh
#
# http://www.elasticsearch.org/guide/en/elasticsearch/reference/master/modules-snapshots.html
#
echo "Set backup"
curl -s -X PUT http://localhost:9200/_snapshot/ldgourmet_backup \
 -d '{
  "type": "fs",
  "settings": {
    "location": "/var/tmp/ldgourmet_backup",
    "compress": true
  }
}'

# location
#   Location of the snapshots. Mandatory.
#
# compress
#   Turns on compression of the snapshot files. Defaults to true.
#
# concurrent_streams
#   Throttles the number of streams (per node) preforming snapshot
#   operation. Defaults to 5
#
# chunk_size
#   Big files can be broken down into chunks during snapshotting
#   if needed. The chunk size can be specified in bytes or by using
#   size value notation, i.e. 1g, 10m, 5k. Defaults to null
#   (unlimited chunk size).
#
# max_restore_bytes_per_sec
#   Throttles per node restore rate. Defaults to 20mb per second.
#
# max_snapshot_bytes_per_sec
#   Throttles per node snapshot rate. Defaults to 20mb per second.
echo
echo
echo "Get backup setting"
curl -s 'http://localhost:9200/_snapshot/?pretty'

echo
echo
echo "Creating snapshot"
time curl -s -X PUT "http://localhost:9200/_snapshot/ldgourmet_backup/$(date +%Y%m%d%H%M%S)?wait_for_completion=true&pretty" -d '{
  "indices": "ldgourmet"
}'

echo
echo
echo "List snapshot"
curl -s 'http://localhost:9200/_snapshot/ldgourmet_backup/_all?pretty'
