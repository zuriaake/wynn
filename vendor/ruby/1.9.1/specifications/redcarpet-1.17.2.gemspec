# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "redcarpet"
  s.version = "1.17.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Natacha Port\u{c3}\u{a9}", "Vicent Mart\u{c3}\u{ad}"]
  s.date = "2011-06-18"
  s.description = "A fast and safe Markdown to (X)HTML parser"
  s.email = "vicent@github.com"
  s.executables = ["redcarpet"]
  s.extensions = ["ext/redcarpet/extconf.rb"]
  s.extra_rdoc_files = ["COPYING"]
  s.files = ["bin/redcarpet", "COPYING", "ext/redcarpet/extconf.rb"]
  s.homepage = "http://github.com/tanoku/redcarpet"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Ruby bindings for libupskirt"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
