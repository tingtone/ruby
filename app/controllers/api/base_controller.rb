require 'base64'
require 'hmac-sha1'

class Api::BaseController < ApplicationController
  before_filter :signature_required

  helper_method :current_player
  helper_method :current_app

  protected
    def player_required
      @current_player = Player.find_by_device_identifier(params[:device_identifier])
      access_denied('no such player') unless @current_player
    end

    def current_player
      @current_player
    end

    def current_app
      @current_app ||= App.find_by_key(params[:key])
    end

    def access_denied(message)
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
      if (key = params['key']) && (@app = App.find_by_key(key)) && (signature = params.delete('signature'))
        Rails.logger.info("----------------->  valid signature true")
        raw_params = if (request.get? || request.delete?)
          request.query_string
        else
          request.raw_post
        end
        raw_params = raw_params.sub!(/&signature=.*$/, '')
        string = "#{request.path}+#{current_app.secret}+#{request.request_method.to_s.upcase}+#{raw_params.gsub("%5B", "[").gsub("%5D", "]")}"
        Rails.logger.info("-----> raw_params: #{raw_params.inspect}")
        Rails.logger.info( "server before signature: ====> #{string.inspect}")
        cal = sign(string, current_app.secret)
        Rails.logger.info("====> current_app: #{current_app.secret}, id: #{current_app.id}")
        client_signature = escape(signature)
        Rails.logger.info("----------------->  cal: #{cal.inspect}, signature: #{signature.inspect}, client_signature: #{client_signature.inspect}" )
        
        cal == client_signature
        # return true
      else
        Rails.logger.info("----------------->  valid signature false,  ")
        false
      end
    end

    def sign(string, secret)
      salt = "#{escape(secret)}"
      Base64.encode64(HMAC::SHA1.digest(salt, string)).chomp.gsub(/\n/,'')
    end

    def escape(value)
      CGI.escape(value.to_s).gsub("%7E", '~').gsub("%20", "+").gsub("%3D", "=").gsub("%2F", "/").gsub("%2B", "+")
    end
end
