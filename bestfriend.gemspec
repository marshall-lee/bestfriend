# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bestfriend/version'

Gem::Specification.new do |gem|
  gem.name          = "bestfriend"
  gem.version       = BestFriend::VERSION
  gem.authors       = ["Vladimir Kochnev"]
  gem.email         = ["hashtable@yandex.ru"]
  gem.description   = %q{Nice FFmpeg DSL}
  gem.summary       = %q{Nice FFmpeg DSL}
  gem.homepage      = "https://github.com/marshall-lee/bestfriend"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.7"
  gem.add_development_dependency "rake", "~> 10.0"
end
