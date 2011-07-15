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
          Rails.logger.info("=======> request.query_string : #{request.query_string}")
        else
          Rails.logger.info("=========> request.raw_post : #{request.raw_post}")
          request.raw_post
        end
        raw_params.sub!(/&signature=.*$/, '')
        Rails.logger.info("=========> request.path : #{request.path}")
        string = "#{request.path}+#{current_app.secret}+#{request.request_method.to_s.upcase}+#{raw_params}"
        Rails.logger.info( "server before signature: ====> #{string}")
        cal = sign(string, current_app.secret)
        Rails.logger.info( "server signature:  cal:#{cal.inspect}")
        Rails.logger.info( "client signature: signature: #{signature.inspect}")
        Rails.logger.info("----------------->  cal: #{cal.inspect}, signature: #{signature.inspect}")
        cal == signature
      else
        Rails.logger.info("----------------->  valid signature false,  ")
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
