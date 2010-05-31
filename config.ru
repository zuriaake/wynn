require ::File.dirname(__FILE__) + '/config/boot.rb'
require 'rack/rewrite'
use Rack::Rewrite do
  r301 %r{(\w+)$}, '$1/'
  rewrite %r{/projects/(\w+)/}, '/projects/$1/index.html'
end

run Padrino.application