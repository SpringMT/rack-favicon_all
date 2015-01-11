require 'fileutils'

require File.dirname(__FILE__) + '/spec_helper'

describe Rack::FaviconAll do
  app = lambda { |env|
    [200, {'Content-Type' => 'text/plain'}, ["Hello, World!"]]
  }

  context 'confirm to Rack::Lint' do
    subject do
      Rack::Lint.new( Rack::FaviconAll.new(app) )
    end
    it do
      response = Rack::MockRequest.new(subject).get('/')
      expect(response.body).to eq 'Hello, World!'
    end
  end

  context 'return valid favicon' do
    before { Timecop.freeze(Time.now) }
    subject do
      Rack::Lint.new(Rack::FaviconAll.new(app, favicon_path: File.expand_path('images/icon.png', __dir__)))
    end
    it do
      response = Rack::MockRequest.new(subject).get('/favicon.ico')
      expect(response.successful?).to be_truthy
      expect(response.headers["Content-Type"]).to eq "image/x-icon"
      expect(response.headers["Last-Modified"]).to eq Time.now.httpdate
    end
    after { Timecop.return }
  end

  context 'invalid favicon_path' do
    subject do
      Rack::Lint.new(Rack::FaviconAll.new(app, favicon_path: File.expand_path('images/hoge', __dir__)))
    end
    it do
      response = Rack::MockRequest.new(subject).get('/favicon.ico')
      expect(response.successful?).to be_truthy
      expect(response.body).to eq 'Hello, World!'
    end
  end

end

