require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Blog
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    # config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'


    #config.middleware.use Rack::Deflater
    config.middleware.insert 0, Rack::Rewrite do

      unless Rails.env.development?
        r301 %r{.*}, 'http://wynnnetherland.com$&', :if => Proc.new {|rack_env|
          request.host != 'wynnnetherland.com'
        }
      end

      r301 '/blog/link-linkedin-into-your-next-ruby-application', 'https://github.com/pengwynn/linkedin'
      r301 '/blog/font-face-off-typekit-vs-font-squirrel', '/journal/font-face-off-typekit-vs-font-squirrel'
      r301 '/blog/rubyists-meet-underscore-js-your-new-favorite-javascript-library', '/journal/rubyists-meet-underscore-js-your-new-favorite-javascript-library'
      r301 '/blog/sass-up-your-wordpress-themes-with-compass', '/journal/sass-up-your-wordpress-themes-with-compass'
      r301  %r{/projects$}, 'https://github.com/pengwynn'
      r301  %r{/projects/$}, 'https://github.com/pengwynn'
      r301 '/blog', ''
      #/blog/css-mixins-vs-multiple-classes
      r301 '/blog/what-makes-a-good-api-wrapper', '/journal/what-makes-a-good-api-wrapper'
      r301  %r{/projects/faraday-middleware}, 'https://github.com/pengwynn/faraday_middleware'
      r301 '/blog/use-javascript-to-put-github-info-on-your-site', '/journal/use-javascript-to-put-github-info-on-your-site'
      r301 '/blog/font-face-made-easy-with-font-squirrel', '/journal/font-face-made-easy-with-font-squirrel'
      r301 '/blog/ten-things-we-learned-building-tweetcongress-org', '/talks/ten-things-we-learned-building-tweetcongress-org'
      r301  %r{/projects/octokit}, 'https://github.com/pengwynn/octokit'
      r301  %r{/projects/octopussy}, 'https://github.com/pengwynn/octokit'


      r301 '/blog/css-metaframeworks-king-of-all-media', '/talks/css-metaframeworks-king-of-all-media'
      r301 '/blog/archives', '/archives'
      r301  %r{/projects/plancast}, 'https://github.com/pengwynn/plancast'
      r301  %r{/projects/gowalla}, 'https://github.com/pengwynn/gowalla'
      r301  %r{/projects/authentic_jobs}, 'https://github.com/pengwynn/authentic_jobs'
      r301 '/blog/quick-tip-find-missing-methods-with-apidock', '/journal/quick-tip-find-missing-methods-with-apidock'
      r301 '/blog/speed-up-your-api-development-sniff-your-network-calls-on-osx-with-httpscoop', '/journal/speed-up-your-api-development-sniff-your-network-calls-on-osx-with-httpscoop'
      r301  %r{/projects/twitter}, 'https://github.com/jnunemaker/twitter'
      r301 '/blog/enhance-your-site-search-with-opensearch', '/journal/enhance-your-site-search-with-opensearch'
      r301 '/blog/github-fork-queue', '/journal/github-fork-queue'
      r301  %r{/projects/buzzsprout}, 'https://github.com/pengwynn/buzzsprout'
      r301  %r{/projects/chunky-baconfile}, 'https://github.com/pengwynn/chunky-baconfile'
      r301  %r{/projects/linkedin}, 'https://github.com/pengwynn/linkedin'
      r301  %r{/projects/plancast/api}, 'https://github.com/pengwynn/plancast'
      r301  %r{/projects/chargify}, 'https://github.com/pengwynn/chargify'
      r301  %r{/projects/groupon}, 'https://github.com/pengwynn/groupon'
      r301  %r{/projects/readernaut}, 'https://github.com/pengwynn/readernaut'
      r301  %r{/projects/authentic_jobs/api/AuthenticJobs.html}, 'https://github.com/pengwynn/authentic_jobs'
      r301  %r{/projects/chargify/api/Chargify/Client.html}, 'https://github.com/pengwynn/chargify'
      r301  %r{/projects/formstack}, 'https://github.com/pengwynn/formstack'
      r301  %r{/projects/gowalla/api/Gowalla/Client.html}, 'https://github.com/pengwynn/gowalla'
      r301 %r{/projects/topsy}, 'https://github.com/pengwynn/topsy'

      # various blog posts

      r301 %r{/2009/11/link-linkedin-into-your-next-ruby-application/}, 'https://github.com/pengwynn/linkedin'
      r301 %r{/blog/css-mixins-vs-multiple-classes/}, '/journal/css-mixins-vs-multiple-classes/'
      r301 %r{/2009/11/sass-up-your-wordpress-themes-with-compass/}, '/journal/sass-up-your-wordpress-themes-with-compass'
      r301 %r{/linked/2011102001}, '/journal/2011102001/coffeescript-friendly-typefaces-it-s-all-about-the-dashrocket'
    end

  end
end
