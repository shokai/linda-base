require 'rubygems'
require 'bundler/setup'
require 'rack'
require 'sinatra'
$stdout.sync = true if development?

require 'logger'
if development?
  $logger = Logger.new $stdout
  require 'sinatra/reloader'
else
  $logger = Logger.new $stdout
  $logger.level = Logger::INFO
end

require 'sinatra/content_for'
require 'sinatra/rocketio'
require 'sinatra/rocketio/linda'
require 'haml'
require 'sass'
require 'json'
require File.expand_path 'libs/cache', File.dirname(__FILE__)
require File.expand_path 'helper', File.dirname(__FILE__)
require File.expand_path 'auth', File.dirname(__FILE__)
require File.expand_path 'main', File.dirname(__FILE__)

set :haml, :escape_html => true
set :cometio, :allow_crossdomain => true
enable :sessions
set :session_secret, (ENV["SESSION_SECRET"] || "kazusuke-tabetai")

case RUBY_PLATFORM
when /linux/i then EM.epoll
when /bsd/i then EM.kqueue
end
EM.set_descriptor_table_size 15000

run Sinatra::Application
