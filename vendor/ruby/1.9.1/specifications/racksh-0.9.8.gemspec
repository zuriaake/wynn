# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "racksh"
  s.version = "0.9.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marcin Kulik"]
  s.date = "2010-09-02"
  s.email = "marcin.kulik@gmail.com"
  s.executables = ["racksh"]
  s.files = ["bin/racksh"]
  s.homepage = "http://github.com/sickill/racksh"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Console for any Rack based ruby web app"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 1.0"])
      s.add_runtime_dependency(%q<rack-test>, [">= 0.5"])
    else
      s.add_dependency(%q<rack>, [">= 1.0"])
      s.add_dependency(%q<rack-test>, [">= 0.5"])
    end
  else
    s.add_dependency(%q<rack>, [">= 1.0"])
    s.add_dependency(%q<rack-test>, [">= 0.5"])
  end
end
