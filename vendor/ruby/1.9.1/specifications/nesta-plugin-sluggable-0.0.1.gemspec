# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "nesta-plugin-sluggable"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Wynn Netherland"]
  s.date = "2011-09-25"
  s.description = "Sluggable posts for Nesta CMS"
  s.email = ["wynn.netherland@gmail.com"]
  s.homepage = ""
  s.require_paths = ["lib"]
  s.rubyforge_project = "nesta-plugin-sluggable"
  s.rubygems_version = "1.8.10"
  s.summary = "Sluggable posts for Nesta"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nesta>, [">= 0.9.11"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<nesta>, [">= 0.9.11"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<nesta>, [">= 0.9.11"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
