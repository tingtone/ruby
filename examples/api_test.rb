require 'rubygems'
require 'net/http'
require 'uri'
require 'cgi'
require 'base64'
require 'hmac'
require 'hmac-sha1'

key = "Uj0WwBCn9Rmb3yNofvRfJQ"
secret = "VV1Fqowyw9AzQyyAi3wMzKbocUGnpuFrUIT0SSsEZU"

string = "/api/v1/children.json+#{secret}+GET+key=#{key}&parent_id=1"
salt = CGI.escape(secret).gsub("%7E", '~').gsub("+", "%20")
signature = Base64.encode64(HMAC::SHA1.digest(salt, string)).chomp.gsub(/\n/, '')

uri = URI.parse("http://ec2-50-16-134-27.compute-1.amazonaws.com/api/v1/children.json?key=#{key}&parent_id=1&signature=#{signature}")
http = Net::HTTP.new(uri.host, uri.port)

response = http.request_get(uri.request_uri)
puts response.body
