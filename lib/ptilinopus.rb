require "httparty"
require "ptilinopus/version"
require "ptilinopus/errors"

module Ptilinopus
  class API
    include HTTParty
    DEFAULT_HEADER = {"Content-Type" => "application/json"}
    API_PATH = '/api/v1/'
    attr_accessor :api_key
    default_timeout 10 # HTTParty timeout
    base_uri 'https://app.mailerlite.com'

    def initialize(api_key = nil)
      @api_key = api_key || self.class.api_key
    end

    def call(type, method, params = {})
      ensure_api_key(params)

      params = params.merge({apiKey: @api_key})
      response = self.class.send(type, API_PATH + method, body: params.to_json, headers: DEFAULT_HEADER)

      if response.code != 200
        case response.code
        when 400
          raise MailerliteInvalidMethodError.new
        when 401
          raise MailerliteInvalidApiKeyError.new
        when 404
          raise MailerliteBadRequestItemError.new
        else
          raise MailerliteServerError.new
        end
      end

      return response.body
    end

    private

    def ensure_api_key(params)
      unless @api_key || params[:apiKey]
        raise StandardError, "You must set an api_key prior to making a call"
      end
    end

    class << self
      attr_accessor :api_key

      def method_missing(sym, *args, &block)
        new(self.api_key).send(sym, *args, &block)
      end
    end
  end
end
