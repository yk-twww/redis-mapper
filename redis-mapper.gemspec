# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redis/mapper/version'

Gem::Specification.new do |spec|
  spec.name          = "redis-mapper"
  spec.version       = Redis::Mapper::VERSION
  spec.authors       = ["yk-twww"]
  spec.email         = ["yk.twww@gmail.com"]

  spec.summary       = %q{Use Redis as multi-column database for structured data.}
  spec.description   = %q{Use Redis as multi-column database for structured data.}
  spec.homepage      = "https://github.com/yk-twww/redis-mapper"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "redis", ">= 3.0.2"
  spec.add_dependency "msgpack", ">= 0.5"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
