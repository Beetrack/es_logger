# frozen_string_literal: true

require 'jwt'
require 'es_logger/configuration'

module EsLogger
  class Response
    JWT_REGEX = Regexp.new('^(Bearer\s)?(?<token>[a-zA-Z0-9\-_.]+)$')

    def self.call(env)
      payload = {
        params: request_params(env),
        headers: http_headers(env).to_json,
        authorization: decode_jwt_token(env),
        query_string_params: query_string(env)
      }

      return payload unless (controller = env['action_controller.instance'])

      payload.merge!(
        'controller_name' => controller.controller_name,
        'controller_action' => controller.action_name,
        'content_type' => controller.content_type || :none
      )
    end

    def self.query_string(env)
      ::Rack::Utils.parse_nested_query(env['QUERY_STRING'])
    end

    def self.request_params(env)
      request = ::Rack::Request.new(env)
      return unless request&.media_type

      is_json = request.media_type.downcase == 'application/json'
      return unless is_json

      request.body.rewind if (body_stream = request.body.read)
      return unless body_stream.length.positive?

      JSON.parse(body_stream)
    end

    def self.http_headers(env)
      env.select { |k, _| k.to_s.start_with? 'HTTP_' }
    end

    def self.decode_jwt_token(env)
      jwt = EsLogger.configuration.jwt
      return if jwt.nil?

      jwt_key = "HTTP_#{jwt.upcase}"
      jwt_value = env[jwt_key].to_s.match(JWT_REGEX)[:token]
      return if jwt_value.nil?

      JWT.decode(jwt_value, nil, false).first
    rescue JWT::DecodeError
      nil
    end
  end
end
