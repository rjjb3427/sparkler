# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sparkler/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "sparkler"
  gem.version       = Sparkler::VERSION
  gem.date          = Date.today.strftime('%Y-%m-%d')
  gem.authors       = ["Chris Moore"]
  gem.email         = ["chrism@gaslight.co"]
  gem.summary       = %q{Generate a Rails app using Gaslight's choices of gems and frameworks.}
  gem.description   = %q{Spin up a Rails app using all the tools and frameworks we like at Gaslight. Inspired heavily by thoughtbot's Suspenders.}
  gem.homepage      = "https://github.com/gaslight/sparkler"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rails', '4.0.0'
  gem.add_dependency 'bundler', '>= 1.1'
end
