require 'bundler'
Bundler.require
require 'sass/plugin/rack'
require './app'

Sass::Plugin.options[:template_location] = 'views/stylesheets'
use Sass::Plugin::Rack
run Sinatra::Application
