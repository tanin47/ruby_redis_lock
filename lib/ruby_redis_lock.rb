require 'redis'

require File.expand_path('../ruby_redis_lock/ruby_redis_lock', __FILE__)


class Redis
  include RubyRedisLock
  
end