# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "ruby_redis_lock"
  s.version     = "0.1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tanin Na Nakorn"]
  s.email       = ["tanin47@yahoo.com"]
  s.homepage    = "http://github.com/tanin47/ruby_redis_lock"
  s.summary     = %q{RubyRedisLock is a distributed lock for Ruby (using Redis)}
  s.description = %q{distributed lock for Ruby (using Redis)}

  s.rubyforge_project = "ruby_redis_lock"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {coverage,spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

end
