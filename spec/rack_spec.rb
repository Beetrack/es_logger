require 'spec_helper'

RSpec.describe EsLogger::Rack, elasticsearch: true do
  let(:app) { Support::MockRackApp.new }
  let(:es_logger) { EsLogger::Rack.new(app) }
  let(:request) { Rack::MockRequest.new(es_logger) }
  let!(:configure) do
    EsLogger.configure do |c|
      c.elasticsearch_index_name = 'test.request'
      c.include_pattern = [/^\/api\/external\/+w/, /^\/api\/external/]
      c.elasticsearch = {
        user: ENV['TEST_ELASTICSEARCH_USER'] || 'elastic',
        password: ENV['TEST_ELASTICSEARCH_PASSWORD'] || '',
        host: ENV['TEST_ELASTICSEARCH_HOST'] || 'localhost',
        port: ENV['TEST_ELASTICSEARCH_PORT'] || 9250
      }
    end
  end
  let!(:elasticsearch_client) { EsLogger::Elasticsearch::ClientConnectionPool.instance.register_credentials }

  context 'process request' do
    before(:all) do
      @identifier = 'abc123'
      @name = 'test'
    end

    it 'method GET' do
      request.get("/api/external/routes?name=#{@name}&identifier=#{@identifier}", 'content-type' => 'application/json')
      expect(es_logger.processed).to eq(true)
    end

    it 'method POST' do
      data = StringIO.new("identifier=#{@identifier}&name=#{@name}")
      request.post('/api/external/routes/create', input: data, 'content-type' => 'application/json')
      expect(es_logger.processed).to eq(true)
    end
  end

  context 'validate routes' do
    it 'include pattern' do
      request.get('/api/external')
      expect(es_logger.processed).to eq(true)
    end

    it 'exclude pattern' do
      request.get('/cable')
      expect(es_logger.processed).to eq(false)
    end
  end

  context 'sidekiq support' do
    it 'complete job' do
      EsLogger.configure(&:use_sidekiq)
      request.get('/api/external/async-task')
      expect(es_logger.processed).to eq(true)
    end
  end
end
