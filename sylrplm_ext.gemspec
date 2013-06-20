# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sylrplm_ext/version'

Gem::Specification.new do |gem|
  gem.name          = "sylrplm_ext"
  gem.version       = SylrplmExt::VERSION
  gem.authors       = ["sylvani"]
  gem.email         = ["sylvani@laposte.net"]
  gem.description   = %q{PLM extensions}
  gem.summary       = %q{PLM extensions}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
