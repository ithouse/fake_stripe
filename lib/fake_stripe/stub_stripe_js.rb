require 'capybara'
require 'capybara/server'
require 'fake_stripe/utils'
require 'sinatra/base'

module FakeStripe
  class StubStripeJS < Sinatra::Base
    get '/v1/' do
      file_path = File.join(File.dirname(__FILE__), '/assets/v1.js')

      content_type 'text/javascript'
      status 200
      IO.read(file_path)
    end

    get '/v2/' do
      file_path = File.join(File.dirname(__FILE__), '/assets/v2.js')
      mock_file_path = File.join(File.dirname(__FILE__), '/assets/v2-mock.js')

      content_type 'text/javascript'
      status 200
      IO.read(file_path) + IO.read(mock_file_path)
    end

    get '/v3/' do
      file_path = File.join(File.dirname(__FILE__), '/assets/v3.js')

      content_type 'text/javascript'
      status 200
      IO.read(file_path)
    end

    def self.boot(port = FakeStripe::Utils.find_available_port)
      instance = new
      retry_count = 10
      begin
        Capybara::Server.new(instance, port).tap { |server| server.boot }
      rescue Errno::EADDRINUSE
        retry_count -= 1
        if retry_count > 0
          port = FakeStripe::Utils.find_available_port
          retry
        end
      end
    end


    def self.boot_once
      @@stripe_js_server ||= FakeStripe::StubStripeJS.boot(self.server_port)
    end

    def self.server_port
      @@stripe_js_port ||= FakeStripe::Utils.find_available_port
    end
  end
end
