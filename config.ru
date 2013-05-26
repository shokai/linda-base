require 'rubygems'
require 'bundler/setup'
require 'sinatra'
$stdout.sync = true if development?
require 'sinatra/reloader' if development?
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
require File.expand_path 'main', File.dirname(__FILE__)

set :haml, :escape_html => true

run Sinatra::Application
