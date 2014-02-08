#!/bin/sh

curl -s -XGET 'http://localhost:9200/ldgourmet/restaurant/_search?pretty=true' -d '
{
  "query" : {
    "function_score" : {
      "query" : {
        "simple_query_string" : {
          "query": "ハンバーガー",
          "fields": ["name", "name_kana", "address"],
          "default_operator": "and"
        }
      },
      "score_mode": "first",
      "boost_mode": "multiply",
      "functions" : [
        {
          "filter" : { "range" : { "access_count" : { "from" : 500 }}},
          "boost_factor" : 10
        },
        {
          "filter" : { "range" : { "photo_count" : { "from" : 3 }}},
          "boost_factor" : 10
        },
        {
          "filter" : { "geo_distance" : { "distance" : "2km", "location" : [139.43 , 35.38] }},
          "boost_factor" : 100
        }
      ]
    }
  }
}
'
