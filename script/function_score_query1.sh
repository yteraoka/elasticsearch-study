#!/bin/sh

curl -s -XGET 'http://localhost:9200/ldgourmet/restaurant/_search?pretty=true' -d '
{
  "query" : {
    "function_score" : {
      "query" : {
        "simple_query_string" : {
          "query": "ラーメン",
          "fields": ["name", "name_kana", "address"],
          "default_operator": "and"
        }
      },
      "boost_mode": "replace",
      "script_score" : {
        "script" : "doc[\"access_count\"].value * doc[\"photo_count\"].value"
      }
    }
  }
}
'
