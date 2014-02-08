#!/bin/sh

curl -s -XGET 'http://localhost:9200/ldgourmet/restaurant/_search?pretty=true' -d '
{
  "query" : {
    "simple_query_string" : {
      "query": "目黒 とんき",
      "fields": ["_all"],
      "default_operator": "and"
    }
  }
}
'
