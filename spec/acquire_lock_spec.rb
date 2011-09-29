require 'spec_helper'

describe 'acquire_lock' do
  
  it "acquires the lock if it does not exist" do
    @redis.send(:acquire_lock, "test").should == true
  end
  
  it "acquires the lock if it is expired" do
    
    @redis.send(:acquire_lock, "test", 0.1).should == true
    
    sleep(1)
    @redis.send(:acquire_lock, "test").should == true
    
  end
  
  it "raise errors when acquiring the lock takes too long" do
    
    @redis.send(:acquire_lock, "test", 60, 60).should == true
    
    lambda { @redis.send(:acquire_lock, "test", 60, 1) }.should raise_error
    
  end
  
  it "waits until the other thread finishes and acquire lock" do
    
    start_time = Time.now.to_i
    @redis.send(:acquire_lock, "test", 60, 60).should == true
    
    Thread.new { 
      Thread.current.join(1)
      sleep(5)
      @redis.send(:release_lock, "test", 60).should == true
    }
    
    Thread.current.join(1)
    @redis.send(:acquire_lock, "test", 60, 20).should == true
    
    (Time.now.to_i - start_time).should be > 4
    
  end
  
end