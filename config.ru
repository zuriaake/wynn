require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

# The project root directory
root = ::File.dirname(__FILE__)

# Compile Sass on the fly with the Sass plugin. Some production environments
# don't allow you to write to the file system on the fly (like Heroku).
# Remove this conditional if you want to compile Sass in production.
if ENV['RACK_ENV'] != 'production'
  require 'sass'
  require 'sass/plugin/rack'
  require 'compass'

  Compass.add_project_configuration(root + '/config.rb')
  Compass.configure_sass_plugin!

  use Sass::Plugin::Rack  # Sass Middleware
end

# Code highlighting
# require 'pygments'
# require 'rack/codehighlighter'
# use Rack::Codehighlighter, :pygments, :element => "pre>code", :markdown => true

# Nice looking 404s and other messages
use Rack::ShowStatus

# Nice looking errors
use Rack::ShowExceptions

require 'rack/rewrite'
use Rack::Rewrite do

  r301 %r{.*}, 'http://wynnnetherland.com$&', :if => Proc.new {|rack_env|
    rack_env['rack.url_scheme'] == 443
  }

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

# Nesta
require 'nesta/app'
Nesta::App.root = root
run Nesta::App
