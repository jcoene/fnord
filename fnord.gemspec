# -*- encoding: utf-8 -*-
require File.expand_path("../lib/fnord/version", __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jason Coene"]
  gem.email         = ["jcoene@gmail.com"]
  gem.description   = %q{A FnordMetric client for Ruby}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/jcoene/fnord"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "fnord"
  gem.require_paths = ["lib"]
  gem.version       = Fnord::VERSION

  gem.add_development_dependency "rspec", "~> 2.8.0"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "growl"
end
