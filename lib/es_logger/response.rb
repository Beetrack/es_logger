# frozen_string_literal: true

module EsLogger
  class Response
    def self.call(env)
      request = ::Rack::Request.new(env)
      is_json = request.media_type.downcase == 'application/json'
      body_stream = is_json ? request.body.read : nil
      request.body.rewind if body_stream

      payload = {
        remote_address: env['REMOTE_ADDR'],
        request_method: env['REQUEST_METHOD'],
        path: env['PATH_INFO'],
        query_string_params: ::Rack::Utils.parse_nested_query(env['QUERY_STRING']),
        params: is_json && body_stream.length.positive? ? JSON.parse(body_stream) : nil
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
