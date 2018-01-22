
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dds_client/version"

Gem::Specification.new do |spec|
  spec.name          = "dds_client"
  spec.version       = DdsClient::VERSION
  spec.authors       = ["Tadej Borovšak"]
  spec.email         = ["tadej.borovsak@xlab.si"]

  spec.summary       = "DICE Deployment Service API wrapper"
  spec.description   = "DICE Deployment Service API wrapper"
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faraday", "~> 0.14"
  spec.add_runtime_dependency "thor", "~> 0.20"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.52"
end
