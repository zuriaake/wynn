# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ripl"
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gabriel Horner"]
  s.date = "2011-08-09"
  s.description = "ripl is a light, modular alternative to irb. Like irb, it loads ~/.irbrc, has autocompletion and keeps history in ~/.irb_history.  Unlike irb, it is highly customizable via plugins and supports commands i.e. ripl-play.  This customizability makes it easy to build custom shells (i.e. for a gem or application) and complex shells (i.e. for the web). In other words, ripl is also a shell framework."
  s.email = "gabriel.horner@gmail.com"
  s.executables = ["ripl"]
  s.extra_rdoc_files = ["README.rdoc", "LICENSE.txt"]
  s.files = ["bin/ripl", "README.rdoc", "LICENSE.txt"]
  s.homepage = "http://github.com/cldwalker/ripl"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "tagaholic"
  s.rubygems_version = "1.8.10"
  s.summary = "ruby interactive print loop - A light, modular alternative to irb and a shell framework"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bond>, ["~> 0.4.0"])
      s.add_development_dependency(%q<bacon>, [">= 1.1.0"])
      s.add_development_dependency(%q<rr>, [">= 1.0.0"])
      s.add_development_dependency(%q<bacon-bits>, [">= 0"])
      s.add_development_dependency(%q<bacon-rr>, [">= 0"])
    else
      s.add_dependency(%q<bond>, ["~> 0.4.0"])
      s.add_dependency(%q<bacon>, [">= 1.1.0"])
      s.add_dependency(%q<rr>, [">= 1.0.0"])
      s.add_dependency(%q<bacon-bits>, [">= 0"])
      s.add_dependency(%q<bacon-rr>, [">= 0"])
    end
  else
    s.add_dependency(%q<bond>, ["~> 0.4.0"])
    s.add_dependency(%q<bacon>, [">= 1.1.0"])
    s.add_dependency(%q<rr>, [">= 1.0.0"])
    s.add_dependency(%q<bacon-bits>, [">= 0"])
    s.add_dependency(%q<bacon-rr>, [">= 0"])
  end
end
