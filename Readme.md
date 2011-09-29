Ruby-Redis-Lock - Distributed lock for Ruby (using Redis)
=======================================================

A distributed lock that utilizes Redis.
It also handles failures.
If a process acquires a lock for more than some period of time (default is 60 seconds), 
the lock is automatically released.

Basically, it follows the algorithm explained here: http://redis.io/commands/setnx

Nevertheless, the algorithm on releasing a lock is improved. Please the comments in http://redis.io/commands/setnx

The example of using it:

```ruby

$redis = Redis.new

$redis.lock('some_name', 60, 10) do
 
 #
 # Do some tasks here
 #
 
end

```

The API is below:

```ruby
lock(lock_name, processing_timeout=60, acquiring_timout=10)
```

You can change processing_timeout and acquiring_timeout.

The lock will be expired after it has been acquired for a period of time longer than processing_timeout (in seconds).

An error will be raised if the lock cannot be acquired within acquiring_timeout (in seconds).

Installation
------------------

You can install it directly by:

```sh
gem install ruby_redis_lock
```

or put it in your Gemfile:

```sh
gem 'ruby_redis_lock'
```

Help me
--------------

1. Clone the project
2. Install all dependencies with
```
bundle install
```
3. Start Redis and running all test cases
```
bundle exec rspec spec/*
```
4. Add a feature, if everything is ok
5. Write tests for the feature
6. Send me a pull request


Author
------------
Tanin Na Nakorn


Boring legal stuff
-------------------

You can do whatever you want with it
