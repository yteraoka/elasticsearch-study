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

reader = CSV.open(opts[:file], "r")
header = reader.take(1)[0]
reader.each do |row|
  hash = Hash[*[header, row].transpose.flatten]
  id = hash.delete("id")
  put_data = JSON::dump(hash)
  res = http.request_put("/#{opts[:index]}/#{opts[:type]}/#{id}", put_data)
  puts res.body
end
