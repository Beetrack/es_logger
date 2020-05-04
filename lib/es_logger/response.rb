# frozen_string_literal: true

module EsLogger
  class Response
    def self.call(env)
      payload = {
        remote_address: env['REMOTE_ADDR'],
        request_method: env['REQUEST_METHOD'],
        path: env['PATH_INFO'],
        query_string_params: ::Rack::Utils.parse_nested_query(env['QUERY_STRING']),
        params: ::Rack::Utils.parse_nested_query(env['rack.input'].read, '&')
      }

      env['rack.input'].rewind

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
