# Settings

# Core strategy
default_run_options[:pty] = true
set :use_sudo, false

set :group, "www-data"

# SCM
set :scm, :git
set :git_shallow_clone, 1
set :branch, "master"
set :deploy_via, :remote_cache
set :copy_exclude, %w(test .git doc)

# Bundler
set :bundle_cmd, "/usr/local/bin/bundle"

# Symlinks
set :normal_symlinks, ["config/database.yml", "config/gopay.yml"]

set :directory_symlinks, {
  'assets'   => 'public/assets',
  'uploads'  => 'public/uploads',
}

# Miscs
set :keep_releases, 3
after "deploy:update", "deploy:cleanup" 


