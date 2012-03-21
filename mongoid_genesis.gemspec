# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "mongoid_genesis"
  s.version     = '0.0.1'
  s.authors     = ["Sebastien Rosa"]
  s.email       = ["sebastien@demarque.com"]
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.licenses = ["MIT"]
  s.homepage    = "http://www.demarque.com"
  s.summary     = "Preserve the original data of a model."
  s.description = "Mongoid Genesis will give you the ability to override attribute values without losing the original one."

  s.rubyforge_project = "mongoid_genesis"

  s.files         = Dir.glob('{lib,spec}/**/*') + %w(LICENSE README.md Rakefile Gemfile)
  s.require_paths = ["lib"]

  s.add_runtime_dependency('mongoid', ['>= 2.0'])
  s.add_development_dependency("bson_ext", "~> 1.6")
  s.add_development_dependency('rake', ['>= 0.8.7'])
  s.add_development_dependency('rspec', ['>= 2.0'])
end
