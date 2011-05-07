require 'rubygems'
require 'net/http'
require 'uri'
require 'cgi'
require 'base64'
require 'hmac'
require 'hmac-sha1'

key = "Uj0WwBCn9Rmb3yNofvRfJQ"
secret = "VV1Fqowyw9AzQyyAi3wMzKbocUGnpuFrUIT0SSsEZU"

uri = URI.parse("http://ec2-50-16-134-27.compute-1.amazonaws.com:3000/api/v1/client_applications/1.json?key=value")
http = Net::HTTP.new(uri.host, uri.port)

string = "/api/v1/client_applications/1.json+#{secret}+GET+key=value"
salt = CGI.escape(secret).gsub("%7E", '~').gsub("+", "%20")
encrypted_string = Base64.encode64(HMAC::SHA1.digest(salt, string)).chomp.gsub(/\n/, '')

puts string
puts salt
puts encrypted_string

headers = {
  "X_OF_KEY" => key,
  "X_OF_SIGNATURE" => encrypted_string
}
response = http.request_get(uri.request_uri, headers)
puts response.body
