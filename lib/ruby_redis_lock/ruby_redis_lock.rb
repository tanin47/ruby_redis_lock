module RubyRedisLock
  

  def lock(lock_name, processing_timeout=60, acquiring_timout=10)
    acquire_lock(lock_name, processing_timeout, acquiring_timout)
    yield
  ensure
    release_lock(lock_name, processing_timeout)
  end
  
  
  private
    def acquire_lock(lock_name, processing_timeout=60, acquiring_timeout=10)
      
      start_time = Time.now.to_i
      
      while !try_acquire_lock(lock_name, processing_timeout)
      
        sleep(rand(100).to_f/100.0)
      
        if (Time.now.to_i - start_time) > acquiring_timeout
          raise Exception, "Acquiring lock timeout > #{acquiring_timeout} seconds"
        end
        
      end
      
      return true
    
    end
  
    def try_acquire_lock(lock_name, processing_timeout=60)
      
      ret = self.setnx(ruby_redis_lock_key(lock_name), "#{Time.now.to_i + processing_timeout}")
      return true if ret == true
      
      expiration = self.get(ruby_redis_lock_key(lock_name)).to_i
      return false if Time.now.to_i < expiration

      previous_expiration = self.getset(ruby_redis_lock_key(lock_name), "#{Time.now.to_i + processing_timeout}").to_i
      return true if expiration == previous_expiration
      
      return false
      
    end
    
    def release_lock(lock_name, processing_timeout=60)
      
      expiration = self.get(ruby_redis_lock_key(lock_name)).to_i
      return false if Time.now.to_i > expiration
      
      previous_expiration = self.getset(ruby_redis_lock_key(lock_name), "#{Time.now.to_i + processing_timeout}").to_i
      
      if expiration == previous_expiration # it still owns the lock
        self.del(ruby_redis_lock_key(lock_name))
        return true
      end
      
      return false
    end
  
    def ruby_redis_lock_key(lock_name)
      "RubyRedisLock:#{lock_name}"
    end
  

end