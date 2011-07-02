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
      if (key = params['key']) && (@client_application = ClientApplication.find_by_key(key)) && (signature = params.delete('signature'))
        raw_params = if (request.get? || request.delete?)
          request.query_string
        else
          if params[:child].try(:[], :avatar)
            text = "&child[birthday]=#{params[:child][:birthday]}"
            text << "child[fullname]=#{params[:child][:fullname]}"
            text << "&child[gender]=#{params[:child][:gender]}"
            if params[:child][:rule_definitions_attributes]
              text << "&child[rule_definitions_attributes][0][period]=#{params[:child][:rule_definitions_attributes][0][:period]}"
              text << "&child[rule_definitions_attributes][0][time]=#{params[:child][:rule_definitions_attributes][0][:time]}"
              text << "&child[rule_definitions_attributes][1][period]=#{params[:child][:rule_definitions_attributes][1][:period]}"
              text << "&child[rule_definitions_attributes][1][time]=#{params[:child][:rule_definitions_attributes][1][:time]}"
              text << "&child[rule_definitions_attributes][2][period]=#{params[:child][:rule_definitions_attributes][2][:period]}"
              text << "&child[rule_definitions_attributes][2][time]=#{params[:child][:rule_definitions_attributes][2][:time]}"
              text << "&child[rule_definitions_attributes][3][period]=#{params[:child][:rule_definitions_attributes][3][:period]}"
              text << "&child[rule_definitions_attributes][3][time]=#{params[:child][:rule_definitions_attributes][3][:time]}"
            end
            if params[:parent_id]
              text << "&parent_id=#{params[:parent_id]}"
            end
          else
            request.raw_post
          end
        end
        raw_params.sub!(/&signature=.*$/, '')
        # remove child avatar
        raw_params.sub!(/child\[avatar\]=.*?&/, '')
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
