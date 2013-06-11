require 'dalli'
require 'json'

class Cache
  @@client = Dalli::Client.new(
                               (ENV['MEMCACHIER_SERVERS'] || ENV['MEMCACHE_SERVERS'] || 'localhost:11211'),
                               {
                                 :username => (ENV['MEMCACHIER_USERNAME'] || ENV['MEMCACHE_USERNAME']),
                                 :password => (ENV['MEMCACHIER_PASSWORD'] || ENV['MEMCACHE_PASSWORD'])
                               }
                               )
  @@caches = Hash.new{|h,k| h[k] = Cache::Client.new(k) }

  def self.client
    @@client
  end

  def self.[](name)
    @@caches[name] rescue halt 500, "cache error"
  end

  class Client
    attr_reader :name

    def initialize(name)
      @name = "linda_base_#{name}_"
    end

    def get(key)
      res = Cache::client.get "#{@name}_#{key}"
      return nil if res.to_s.empty?
      JSON.parse res rescue return nil
    end

    def [](key)
      get key
    end

    def set(key, value, opts={:expire => 3600*24*14})
      Cache::client.set "#{@name}_#{key}", value.to_json, opts[:expire]
      value
    end

    def []=(key, value)
      set key, value
    end

    def delete(key)
      Cache::client.delete "#{@name}_#{key}"
    end
  end
end
