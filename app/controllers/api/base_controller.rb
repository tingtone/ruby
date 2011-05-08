require 'base64'
require 'hmac-sha1'

class Api::BaseController < ApplicationController
  before_filter :signature_required
  before_filter :parent_required

  helper_method :current_parent

  private
    def current_parent
      @current_parent
    end

    def parent_required
      @current_parent = Parent.find_by_authentication_token(params[:authentication_token])
      access_denied('no such authentication_token')
    end

    def access_denied(message)
      head :unauthorized
      render :json => { :error => true, :messages => [message] }
      return false
    end

    def signature_required
      unless has_valid_signature?
        access_denied('invalid signature')
        return false
      else
        return true
      end
    end

    def has_valid_signature?
      return true if params['no_sign'] && !Rails.env.production?
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
      Base64.encode64(HMAC::SHA1.digest(salt, string)).chomp.gsub(/\n/,'').gsub('+', ' ')
    end

    def escape(value)
      CGI.escape(value.to_s).gsub("%7E", '~').gsub("+", "%20")
    end
end
