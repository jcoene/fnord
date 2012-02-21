# -*- encoding: utf-8 -*-

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
  gem.version       = "0.0.1"

  gem.add_dependency "json"

  gem.add_development_dependency "rspec", "~> 2.8.0"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "growl"
end
