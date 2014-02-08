#!/bin/sh

curl -s -XGET 'http://localhost:9200/ldgourmet/restaurant/_search?pretty=true' -d '
{
  "query" : {
    "simple_query_string" : {
      "query": "白金台 カフェ ボエム",
      "fields": ["name", "name_kana", "address"],
      "default_operator": "and"
    }
  }
}
'
