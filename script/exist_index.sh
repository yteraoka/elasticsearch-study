#!/bin/sh
#
# http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/indices-exists.html
#

curl -v -X HEAD "http://localhost:9200/$1"
