module RackESLogger
  class Response
    def initialize(env)
      @env = env
    end

    def call
      payload = {
        remote_address: @env['REMOTE_ADDR'],
        request_method: @env['REQUEST_METHOD'],
        path: @env['PATH_INFO'],
        query_string_params: Rack::Utils.parse_nested_query(@env['QUERY_STRING']),
        params: Rack::Utils.parse_query(@env['rack.input'].read, '&')
      }

      payload.merge!(controller_metrics(@env['action_controller.instance']))
      payload
    end

    def controller_metrics(controller)
      return {} if controller.nil?

      {
        controller_name: controller.controller_name,
        controller_action: controller.action_name,
        content_type: controller.content_type || :none
      }
    end
  end
end
