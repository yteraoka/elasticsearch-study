#!/bin/sh
#
# http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/cluster-health.html
#

curl -s 'http://localhost:9200/_cluster/health?pretty=true'
