$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require 'bundler/capistrano'

set :application, "sanderstead_parish"
set :repository,  "git@github.com:nicholashibberd/sanderstead_parish.git"
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
                    # This may be the same as your `Web` server

role :web, "31.222.140.79"                          # Your HTTP server, Apache/etc
role :app, "31.222.140.79"

ssh_options[:forward_agent] = true
set :keep_releases, 5

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
set :deploy_via, :remote_cache

set :user, "www-data"
set :branch, "master"
set :use_sudo, false

set :deploy_to, "/var/www/#{application}"

namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
end