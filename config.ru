require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/rocketio'
require 'sinatra/rocketio/linda'
require 'haml'
require File.expand_path 'main', File.dirname(__FILE__)

run Sinatra::Application
