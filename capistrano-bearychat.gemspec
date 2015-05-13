# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "capistrano-bearychat"
  gem.version       = "1.0"
  gem.authors       = ["Kai Chen"]
  gem.email         = ["kai@thekaiway.com"]
  gem.description   = %q{Send notifications to Bearychat about Capistrano deployments.}
  gem.summary       = %q{Send notifications to Bearychat about Capistrano deployments.}
  gem.homepage      = "https://github.com/kaichen/capistrano-bearychat"
  gem.license       = 'MIT'

  gem.required_ruby_version = '>= 2.0.0'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'capistrano', '>= 3.0.1'
  gem.add_dependency 'json'
  gem.add_development_dependency 'rake'
end
