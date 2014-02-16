#!/bin/sh
#
# http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/cluster-state.html
#
curl -s 'http://localhost:9200/_cluster/state?pretty'
