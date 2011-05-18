require 'base64'
require 'hmac-sha1'

class Api::BaseController < ApplicationController
  before_filter :signature_required

  helper_method :current_parent
  helper_method :current_child
  helper_method :current_client_application

  protected
    def current_child
      @current_child
    end

    def child_required
      @current_child = Child.find_by_id(params[:child_id])
      access_denied('no such child') unless @current_child
    end

    def current_parent
      @current_parent
    end

    def parent_required
      @current_parent = Parent.find_by_id(params[:parent_id])
      access_denied('no such parent') unless @current_parent
    end

    def current_client_application
      @client_application ||= ClientApplication.find_by_key(params[:key])
    end

    def access_denied(message)
      render :json => { :error => true, :messages => [message] }, :status => :unauthorized
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
      if (key = params['key']) && (@client_application = ClientApplication.find_by_key(key)) && (signature = params.delete('signature'))
        raw_params = if (request.get? || request.delete?)
          request.query_string
        else
          request.raw_post
        end
        raw_params.sub!(/&signature=.*$/, '')
        string = "#{request.path}+#{current_client_application.secret}+#{request.request_method.to_s.upcase}+#{raw_params}"
        cal = sign(string, current_client_application.secret)
        cal == signature
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
