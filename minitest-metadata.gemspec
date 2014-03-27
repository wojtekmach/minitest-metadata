# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "minitest/metadata/version"

Gem::Specification.new do |s|
  s.name        = "minitest-metadata"
  s.version     = MiniTest::Metadata::VERSION
  s.authors     = ["Wojciech Mach"]
  s.email       = ["wojtek@wojtekmach.pl"]
  s.homepage    = ""
  s.summary     = %q{Metadata (key-value) support for minitest/spec}
  s.description = s.summary

  s.rubyforge_project = "minitest-metadata"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "minitest", ">= 4.7", "< 6.0"

  s.add_development_dependency "rake"
end
