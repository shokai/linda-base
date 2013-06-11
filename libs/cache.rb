require 'dalli'
require 'json'

class Cache
  attr_reader :cache, :prefix
  @@client = Dalli::Client.new(
                               (ENV['MEMCACHIER_SERVERS'] || ENV['MEMCACHE_SERVERS'] || 'localhost:11211'),
                               {
                                 :username => (ENV['MEMCACHIER_USERNAME'] || ENV['MEMCACHE_USERNAME']),
                                 :password => (ENV['MEMCACHIER_PASSWORD'] || ENV['MEMCACHE_PASSWORD'])
                               }
                               )

  def self.client
    @@client
  end

  def initialize(prefix="default")
    @prefix = "linda_base_#{prefix}_"
  end

  def get(key)
    res = self.class.client.get "#{@prefix}_#{key}"
    return nil if res.to_s.empty?
    JSON.parse res rescue return nil
  end

  def set(key, value, opts={:expire => 3600*72})
    self.class.client.set "#{@prefix}_#{key}", value.to_json, opts[:expire]
    value
  end

  def delete(key)
    self.class.client.delete "#{@prefix}_#{key}"
  end
end
