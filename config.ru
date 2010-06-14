require ::File.dirname(__FILE__) + '/config/boot.rb'
require 'adsf'
require 'uv'
require 'rack/codehighlighter'

use Rack::Codehighlighter, :ultraviolet, :markdown => true, :theme => 'mac_classic', :element => "pre>code", :pattern => /\A:::(\w+)\s*(\n|&#x000A;)/i, :logging => true


use Adsf::Rack::IndexFileFinder, :root => "public"

require 'rack/rewrite'
use Rack::Rewrite do
  r301 %r{\d{4}\/\d{2}\/([\w-]+)}, '/blog/$1'
end

use CanonicalHost do
  case ENV['RACK_ENV'].to_sym
    when :development then 'wynn.local'
    when :production then 'wynnnetherland.com'
  end
end

run Padrino.application