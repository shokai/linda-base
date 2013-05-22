require 'rubygems'
require 'bundler/setup'
require 'sinatra'
$stdout.sync = true if development?
require 'sinatra/reloader' if development?
require 'sinatra/content_for'
require 'sinatra/rocketio'
require 'sinatra/rocketio/linda'
require 'haml'
require File.expand_path 'main', File.dirname(__FILE__)

set :haml, :escape_html => true

run Sinatra::Application
