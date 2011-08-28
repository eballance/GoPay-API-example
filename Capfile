load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

# Multistage support
set :stages, %w(production staging)
set :default_stage, "staging"
require 'config/deploy/multistage'
require 'bundler/capistrano'


load 'config/deploy/deploy' # remove this line to skip loading any of the default tasks
load 'config/deploy/settings'
Dir['config/deploy/recipes/*.rb'].each { |f| load(f) }

