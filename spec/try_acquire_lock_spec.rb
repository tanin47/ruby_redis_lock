require 'spec_helper'

describe 'try_acquire_lock' do
  
  it "acquires lock when the lock does not exist" do
    
    @redis.send(:try_acquire_lock, "test").should == true
    
  end
  
  it "does not acquire lock when the lock is alive" do
    
    @redis.send(:try_acquire_lock, "test").should == true
    @redis.send(:try_acquire_lock, "test").should == false
    
  end
  
  it "acquires lock when the lock is expired" do
    
    @redis.send(:try_acquire_lock, "test", 0.1).should == true
    
    sleep(1)
    @redis.send(:try_acquire_lock, "test").should == true
    
  end
  
  it "does not acquire lock when the lock is expired but somebody else already successfully acquire the same lock" do
    
  end
  
end