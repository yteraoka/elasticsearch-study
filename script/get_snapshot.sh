#!/bin/sh
echo "Get backup setting"
curl -s 'http://localhost:9200/_snapshot/?pretty'
