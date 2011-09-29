require 'spec_helper'

describe 'release_lock' do
  
  it "release lock when the lock is not expired" do
    
    @redis.send(:acquire_lock, "test", 69).should == true
    
    @redis.send(:release_lock, "test").should == true
    
  end
  
  it "does not release lock if the lock is already expired" do
    
    @redis.send(:acquire_lock, "test", 0.1).should == true
    
    sleep(1)
    @redis.send(:release_lock, "test").should == false
    
  end
  
end