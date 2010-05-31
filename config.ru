require ::File.dirname(__FILE__) + '/config/boot.rb'
require 'adsf'

use Adsf::Rack::IndexFileFinder, :root => "public"

run Padrino.application