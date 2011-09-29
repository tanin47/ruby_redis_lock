# encoding: utf-8
require 'simplecov'
SimpleCov.start do
  coverage_dir("coverage") 
end

require 'rspec'

require File.expand_path("../../lib/ruby_redis_lock",__FILE__)

RSpec.configure do |config|
  
  config.mock_with :rspec
  
  config.before(:each) do
    @redis = Redis.new
    @redis.flushall
  end
  
end