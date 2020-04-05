require_relative 'test_helper'

class EsLoggerAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    app = ->(_env) { [200, { 'Content-Type' => 'text/html' }, ['ok']] }
    @rack_app = EsLogger::Application.new(app)
  end

  def test_get_request
    url = '/api/external/v1/1'
    params = { name: 'name', lastname: 'lastname' }
    get url, params

    puts @rack_app.payload

    default_assert
  end

  def default_assert
    assert last_response.ok?
    assert_equal last_response.body, 'ok'
    assert_equal last_response.headers['Content-Type'], 'text/html'
  end
end
