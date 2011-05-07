require 'rubygems'
require 'net/http'
require 'uri'
require 'cgi'
require 'base64'
require 'hmac'
require 'hmac-sha1'

key = "JwvZDgiVEhGT1SVyyGY3gQ"
secret = "QFe1qP1pZ6SmFdED01CpKHOLs41bWwi2uY27i2AEInM"

uri = URI.parse("http://localhost:3000/api/v1/client_applications/1.json?key=value")
http = Net::HTTP.new(uri.host, uri.port)

string = "/api/v1/client_applications/1.json+#{secret}+GET+key=value"

salt = CGI.escape(secret).gsub("%7E", '~').gsub("+", "%20")
encrypted_string = Base64.encode64(HMAC::SHA1.digest(salt, string)).chomp.gsub(/\n/, '')
puts encrypted_string
headers = {
  "X_OF_KEY" => key,
  "X_OF_SIGNATURE" => encrypted_string
}
response = http.request_get(uri.request_uri, headers)
puts response.body
