require ::File.dirname(__FILE__) + '/config/boot.rb'
require 'adsf'
require 'uv'
require 'rack/codehighlighter'
use Rack::Codehighlighter, :ultraviolet, :markdown => true, :theme => 'mac_classic', :element => "pre>code", :pattern => /\A:::(\w+)\s*(\n|&#x000A;)/i, :logging => true


use Adsf::Rack::IndexFileFinder, :root => "public"

# use Rack::Codehighlighter, :ultraviolet, :markdown => true,
#   :element => "pre>code", :pattern => /\A:::(\w+)\s*(\n|&#x000A;)/i, :logging => false
# 

run Padrino.application