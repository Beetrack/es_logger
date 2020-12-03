# frozen_string_literal: true

require 'jwt'
require 'es_logger/configuration'

module EsLogger
  class Response
    def self.call(env)
      request = ::Rack::Request.new(env)
      is_json = request&.media_type&.downcase == 'application/json'
      body_stream = is_json ? request.body.read : nil
      request.body.rewind if body_stream

      jwt_key = nil

      if !(jwt = EsLogger.configuration.jwt).nil?
        jwt_key = "HTTP_#{jwt.upcase}"
        jwt_value = env[jwt_key].split(' ').last
      end

      decoded_token = JWT.decode(jwt_value, nil, false)
      headers = env.select { |k, _| k.to_s.start_with? 'HTTP_' }

      payload = {
        headers: headers.to_json,
        query_string_params: ::Rack::Utils.parse_nested_query(env['QUERY_STRING']),
        params: is_json && body_stream.length.positive? ? JSON.parse(body_stream) : nil,
        authorization: decoded_token
      }

      controller = env['action_controller.instance']

      if controller
        payload.merge!(
          'controller_name' => controller.controller_name,
          'controller_action' => controller.action_name,
          'content_type' => controller.content_type || :none
        )
      end

      payload
    end
  end
end
