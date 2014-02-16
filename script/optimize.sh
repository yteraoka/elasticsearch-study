#!/bin/sh
#
# http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/indices-optimize.html
#
index=$1

if [ "$1" = "" ] ; then
    echo "Usage: $0 <index>"
    exit 1
fi

curl -s "http://localhost:9200/$index/_optimize"

# curl -s "http://localhost:9200/_optimize"
