require 'base64'
require 'hmac-sha1'

class Api::BaseController < ApplicationController
  before_filter :signature_required

  private
    def signature_required
      unless has_valid_signature?
        head :unauthorized
        return false
      else
        return true
      end
    end

    def has_valid_signature?
      if (key = params['key']) && (game = ClientApplication.find_by_key(key)) && (signature = params.delete('signature'))
        raw_params = if (request.get? || request.delete?)
          request.query_string
        else
          raw_post
        end
        raw_params.sub!(/&signature=.*$/, '')
        string = "#{request.path}+#{game.secret}+#{request.request_method.to_s.upcase}+#{raw_params}"
        sign(string, game.secret) == signature
      else
        false
      end
    end

    def sign(string, secret)
      salt = "#{escape(secret)}"
      Base64.encode64(HMAC::SHA1.digest(salt, string)).chomp.gsub(/\n/,'')
    end

    def escape(value)
      CGI.escape(value.to_s).gsub("%7E", '~').gsub("+", "%20")
    end
end
