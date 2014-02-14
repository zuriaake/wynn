ENV['NESTA_CONTENT'] = File.join(Rails.root, 'content')
ENV['NESTA_TITLE'] = 'Wynn Netherland'
ENV['NESTA_SUBTITLE'] = 'Full stack web creative.'

# ENV['NESTA_AUTHOR__NAME'] = ''
# ENV['NESTA_AUTHOR__URI'] = ''
# ENV['NESTA_AUTHOR__EMAIL'] = ''
#
# ENV['NESTA_DISQUS_SHORT_NAME'] = ''
# ENV['NESTA_GOOGLE_ANALYTICS_CODE'] = ''

require 'sass/util'

require 'nesta/env'
Nesta::Env.root = Rails.root

require 'nesta/app'

Rails.application.config.middleware.insert_after(
  Rack::Lock,
  Rack::Static, :urls => ['/attachments'], :root => File.expand_path('content'))

Haml::Template.options[:format] = :html5

module Tilt
  class MarkdownEmojiSyntaxTemplate < Template

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
        HTML::Pipeline::EmojiFilter,
        HTML::Pipeline::SyntaxHighlightFilter
      ], context

      @output ||= pipeline.call(data)[:output].to_s
    end

    def allows_script?
      false
    end
  end
end

Tilt.register Tilt::MarkdownEmojiSyntaxTemplate, 'mdown'
