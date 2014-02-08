#!/usr/bin/env ruby
require 'csv'
require 'json'
require 'net/http'
require 'uri'
require 'optparse'

opts = {}
opts[:server] = 'localhost'
opts[:port] = 9200
opts[:index] = 'ldgourmet'

opt = OptionParser.new
opt.on('-i', '--index [ES_INDEX_NAME]') {|v| opts[:index] = v }
opt.on('-t', '--type ES_DOCUMENT_NAME', '(rating, restaurant)') {|v| opts[:type] = v }
opt.on('-f', '--file CSV_FILE') {|v| opts[:file] = v }
opt.on('-s', '--server [ES_SERVER_NAME]') {|v| opts[:server] = v }
opt.on('-p', '--port [ES_PORT]') {|v| opts[:port] = v }

opt.parse!(ARGV)

if ! opts[:type] then
  opt.warn "-t option is required"
  exit 1
end
if ! opts[:file] then
  opt.warn "-f option is required"
  exit 1
end

http = Net::HTTP.new(opts[:server], opts[:port])

bulk_info = {}
bulk_info["index"] = {}
bulk_info["index"]["_index"] = opts[:index]
bulk_info["index"]["_type"] = opts[:type]
bulk_info_json = JSON::dump(bulk_info)

reader = CSV.open(opts[:file], "r")
header = reader.take(1)[0]

post_data = []
n = 0
reader.each do |row|
  hash = Hash[*[header, row].transpose.flatten]
  id = hash.delete("id")
  post_data.push(bulk_info_json)
  post_data.push(JSON::dump(hash))
  n = n + 1
  if n % 1000 == 0 then
    res = http.request_post("/_bulk", post_data.join("\n"))
#    puts res.body
    puts n
    post_data = []
  end
end

res = http.request_post("/_bulk", post_data.join("\n"))
#puts res.body
puts n
