ENV['NESTA_CONTENT'] = File.join(Rails.root, 'content')
require 'sass/util'

require 'nesta/env'
Nesta::Env.root = Rails.root

require 'nesta/app'

Rails.application.config.middleware.insert_after(
  Rack::Lock,
  Rack::Static, :urls => ['/attachments'], :root => File.expand_path('content'))

Haml::Template.options[:format] = :xhtml # for the feed

require 'gemoji'
module Tilt
  class PengwynnFlavoredMarkdownTemplate < Template

    def prepare
      @output = nil
    end

    def evaluate(scope, locals, &block)
      context = {
        :asset_root => "https://github.global.ssl.fastly.net/images/icons",
        :base_url   => "http://wynnnetherland.com",
        :gfm        => false
      }
      pipeline = HTML::Pipeline.new [
        HTML::Pipeline::MarkdownFilter,
        HTML::Pipeline::EmojiFilter
      ], context

      @output ||= pipeline.call(data)[:output].to_s
    end

    def allows_script?
      false
    end
  end
end

Tilt.register Tilt::PengwynnFlavoredMarkdownTemplate, 'mdown'
