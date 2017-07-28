# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'safen/version'

Gem::Specification.new do |spec|
  spec.name          = 'safen'
  spec.version       = Safen::VERSION
  spec.authors       = ['subicura']
  spec.email         = ['subicura@subicura.com']

  spec.summary       = %q{Ruby bindings for the SKT safen API}
  spec.description   = %q{SKT safen is 0504 tel service.}
  spec.homepage      = 'https://github.com/subicura/safen-ruby'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
