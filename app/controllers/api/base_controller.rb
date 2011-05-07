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
      if (key = env['HTTP_X_OF_KEY']) && (game = ClientApplication.find_by_key(key)) && (signature = env['HTTP_X_OF_SIGNATURE'])
        uri, raw_params = if (get? || delete?)
          request_uri.split('?')
        else
          [request_uri, raw_post]
        end
        string = "#{uri}+#{game.secret}+#{method.to_s.upcase}+#{raw_params}"
        signature(string, game.secret) == signature
      else
        false
      end
    end

    def signature(string, secret)
      salt = "#{escape(secret)}"
      Base64.encode64(HMAC::SHA1.digest(salt, string)).chomp.gsub(/\n/,'')
    end
end
