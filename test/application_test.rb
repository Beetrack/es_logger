require_relative 'test_helper'

class RackESLoggerAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    app = lambda { |env| [200, { 'Content-Type' => 'text/html' }, ['ok']] }
    RackESLogger::Application.new(app)
  end

  def test_get_request
    get '/api/external/v1/1', name: 'name', lastname: 'lastname'

    assert last_response.ok?
    assert_equal last_response.headers['Content-Type'], 'text/html'
  end
end
