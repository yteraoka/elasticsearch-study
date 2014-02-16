#!/bin/sh
#
# http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/cluster-stats.html
#
curl -s 'http://localhost:9200/_cluster/stats?human&pretty'
