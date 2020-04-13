module Support
  class MockRackApp
    def call(env)
      @env = env
      [200, { 'Content-Type' => 'text/plain' }, ['OK']]
    end
  end
end
