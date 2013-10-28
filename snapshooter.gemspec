# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snapshooter/version'

Gem::Specification.new do |spec|
  spec.name          = "snapshooter"
  spec.version       = Snapshooter::VERSION
  spec.authors       = ["Julio Santos", "Trae Robrock"]
  spec.email         = ["julio@morgane.com", "trobrock@gmail.com"]
  spec.description   = %q{Simple tool for snapshotting application data.}
  spec.summary       = %q{Simple tool for snapshotting application data.}
  spec.homepage      = "https://github.com/trobrock/snapshooter"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
