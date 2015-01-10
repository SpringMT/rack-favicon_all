require 'rmagick'
require 'rack/favicon_all/version'
require 'pry'

module Rack
  class FaviconAll
    FAVICON = [
      { path: /\A\/favicon\.ico/, size: [16, 16], mime_type: 'image/x-icon', format: 'ICO' },
      { path: /\A\/favicon-16x16\.png/, size: [16, 16] },
      { path: /\A\/favicon-32x32\.png/, size: [32, 32] },
      { path: /\A\/favicon-96x96\.png/, size: [96, 96] },
      { path: /\A\/favicon-160x160\.png/, size: [160, 160] },
      { path: /\A\/favicon-196x196\.png/, size: [196, 196] },
      { path: /\A\/mstile-70x70\.png/, size: [70, 70] },
      { path: /\A\/mstile-144x144\.png/, size: [144, 144] },
      { path: /\A\/mstile-150x150\.png/, size: [150, 150] },
      { path: /\A\/mstile-310x310\.png/, size: [310, 310] },
      { path: /\A\/mstile-310x150\.png/, size: [310, 150] },
      { path: /\A\/apple-touch-icon-57x57\.png/, size: [57, 57] },
      { path: /\A\/apple-touch-icon-60x60\.png/, size: [60, 60] },
      { path: /\A\/apple-touch-icon-72x72\.png/, size: [72, 72] },
      { path: /\A\/apple-touch-icon-76x76\.png/, size: [76, 76] },
      { path: /\A\/apple-touch-icon-114x114\.png/, size: [114, 114] },
      { path: /\A\/apple-touch-icon-120x120\.png/, size: [120, 120] },
      { path: /\A\/apple-touch-icon-144x144\.png/, size: [144, 144] },
      { path: /\A\/apple-touch-icon-152x152\.png/, size: [152, 152] },
      { path: /\A\/apple-touch-icon\.png/, size: [57, 57] },
      { path: /\A\/apple-touch-icon-precomposed\.png/, size: [57, 57] },
    ]
    def initialize(app, options = {})
      @app = app
      @favicon_path = options[:favicon_path]
      @image = Magick::Image.read(@favicon_path).first unless @favicon_path.nil?
    end

    def call(env)
      status, headers, body = @app.call(env)
      return [status, headers, body] if @image.nil?

      favicon_info = FAVICON.find { |f| env['PATH_INFO'] =~ f[:path] }

      return [status, headers, body] if favicon_info.nil?

      body = genarate_favicon(favicon_info)
      headers["Content-Length"] = body.bytesize.to_s
      headers["Content-Type"]   = favicon_info[:mime_type] || "imgae/png"
      [status, headers, [body]]
    end

    private

    def genarate_favicon(info)
      @image.scale!(*info[:size]).to_blob do
        self.format = info[:format] unless info[:format].nil?
      end
    end
  end
end
