require 'bundler/capistrano'
require 'railsless-deploy'

## General Settings (no need to tweak per installation)
# Set the application name on the server
set :application, "hire-me"
# Set the user of your application
set :user, 'ubuntu'
# Github repository
set :repository,  "git@github.com:andruby/hire-me.git"
set :scm, :git
# The amount of release you want to keep
set :keep_releases, 5
# Do you deploy as a sudo user
set :use_sudo, false
set :deploy_via, :remote_cache
# Where do you want to deploy
set :deploy_to, "/var/www/#{application}"

## Tweak these settings per deployment
# Set the Git branch to deploy from
set :branch, :master
# Set the server hostname to deploy to
server "ny.bedesign.be", :app, :primary => true

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# Load config/credentials.rb
path = File.expand_path('../credentials.rb', __FILE__)
load path if File.exists?(path)

Dir['config/recipes/*.rb'].each { |recipe| load recipe }

after "deploy:restart", "deploy:cleanup"
