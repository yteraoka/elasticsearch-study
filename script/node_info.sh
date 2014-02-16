#!/bin/sh
#
# http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/cluster-nodes-info.html
#
curl -s 'http://localhost:9200/_nodes?pretty'
