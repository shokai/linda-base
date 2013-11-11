require 'rubygems'
require 'bundler/setup'
require 'rack'
require 'sinatra'
require 'logger'
$logger = Logger.new $stdout
if development?
  $stdout.sync = true
  $logger.level = Logger::INFO
  require 'sinatra/reloader'
elsif production?
  $logger.level = Logger::WARN
end

require 'sinatra/content_for'
require 'sinatra/rocketio'
require 'sinatra/rocketio/linda'
require 'haml'
require 'sass'
require 'json'
$:.unshift File.dirname(__FILE__)
require 'libs/cache'
require 'libs/code_runner'
require 'helpers/helper'
require 'controllers/auth'
require 'controllers/run_code'
require 'controllers/main'

set :haml, :escape_html => true
set :cometio, :allow_crossdomain => true
enable :sessions
set :session_secret, (ENV["SESSION_SECRET"] || "yakiniku-kazusuke-forumon")

case RUBY_PLATFORM
when /linux/i then EM.epoll
when /bsd/i then EM.kqueue
end
EM.set_descriptor_table_size 20000

run Sinatra::Application
