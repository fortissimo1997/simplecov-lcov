# frozen_string_literal: true

require_relative "lib/simplecov/lcov/version"

Gem::Specification.new do |s|
  s.name = "simplecov-lcov"
  s.version = SimpleCov::Lcov::VERSION

  s.require_paths = ["lib"]
  s.authors = ["fortissimo1997"]
  s.description = "Custom SimpleCov formatter to generate a lcov style coverage."
  s.email = "fortissimo1997@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]
  s.files = [
    "LICENSE.txt",
    "README.markdown",
    "lib/simplecov/lcov/version.rb",
    "lib/simple_cov_lcov/configuration.rb",
    "lib/simplecov-lcov.rb"
  ]
  s.homepage = "https://github.com/fortissimo1997/simplecov-lcov"
  s.licenses = ["MIT"]
  s.required_ruby_version = ">= 2.4.0"
  s.summary = "Custom SimpleCov formatter to generate a lcov style coverage."
  s.metadata["rubygems_mfa_required"] = "true"

  s.add_development_dependency(%q<rspec>, [">= 0"])
  s.add_development_dependency(%q<rdoc>, [">= 0"])
  s.add_development_dependency(%q<bundler>, [">= 0"])
  s.add_development_dependency(%q<rake>, [">= 0"])
  s.add_development_dependency(%q<simplecov>, ["~> 0.18"])
  s.add_development_dependency(%q<coveralls>, [">= 0"])
  s.add_development_dependency(%q<activesupport>, [">= 0"])
end
