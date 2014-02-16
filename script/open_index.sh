#!/bin/sh
#
# http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/indices-open-close.html
#
index=$1

if [ "$1" = "" ] ; then
    echo "Usage: $0 <index>"
    exit 1
fi

curl -s -X POST "http://localhost:9200/$index/_open"
