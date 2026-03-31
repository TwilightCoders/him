# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)
require "him/version"

Gem::Specification.new do |s|
  s.name        = "him"
  s.version     = Him::VERSION
  s.authors     = ["Dale Stevens", "Rémi Prévost"]
  s.email       = ["dale@twilightcoders.net"]
  s.homepage    = "https://github.com/TwilightCoders/him"
  s.license     = "MIT"
  s.summary     = "An ORM that maps REST resources to Ruby objects. Forked from Her."
  s.description = "Him is an ORM that maps REST resources and collections to Ruby objects, designed for RESTful API-powered applications."

  s.required_ruby_version = ">= 3.1"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake", ">= 13.0"
  s.add_development_dependency "rspec", "~> 3.5"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "simplecov-json"

  s.add_runtime_dependency "activemodel", ">= 6.1"
  s.add_runtime_dependency "faraday", ">= 2.0"
end
