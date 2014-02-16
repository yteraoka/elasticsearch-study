#!/bin/sh
#
# http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/states.html
#
if [ $# -ne 1 ] ; then
    echo "Usage: $0 <number_of_replicas>"
fi
curl -s -X PUT http://localhost:9200/_settings \
-d "{\"number_of_replicas\":$1}"
