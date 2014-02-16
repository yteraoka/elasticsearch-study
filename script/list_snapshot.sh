#!/bin/sh
echo "List snapshot"
curl -s 'http://localhost:9200/_snapshot/ldgourmet_backup/_all?pretty'
