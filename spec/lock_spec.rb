require 'spec_helper'

describe 'lock' do
  
  it "acquires the lock if it does not exist" do
    
    @redis.lock("test") { }
    
  end
  
  it "waits and acquire lock" do
    
    start_time = Time.now.to_i
    
    Thread.new {
      @redis.lock("test") { 
        Thread.current.join(1)
        sleep(5) 
      }
    }
    
    Thread.current.join(1)
    
    @redis.lock("test") { }
    
    (Time.now.to_i - start_time).should be > 4
    
  end
  
  it "waits and acquire expired lock" do
    
    start_time = Time.now.to_i
    
    Thread.new {
      @redis.send(:acquire_lock, "test", 5, 10).should == true
    }
    
    Thread.current.join(0.1)
    
    @redis.lock("test") { }
    
    (Time.now.to_i - start_time).should be > 4
    
  end
  
  it "fails to acquire lock" do
    
    Thread.new {
      @redis.lock("test") { 
        Thread.current.join(1)
        sleep(5) 
      }
    }
    
    Thread.current.join(1)
    lambda { @redis.lock("test", 10, 2) {  } }.should raise_error
    
  end
  
  it "correctly release the lock when error is raised" do
    
    begin
      @redis.lock("test") { 
        raise 'some error'
      }
    rescue
    end
    
    @redis.get(@redis.send(:ruby_redis_lock_key, "test")).should == nil
    
  end
  
end