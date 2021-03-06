set :application, "89.111.24.210"
set :repository,  "git@github.com:artturs91/test.git"

 set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, 'root'
set :user_sudo, false
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache


role :web, "89.111.24.210"                          # Your HTTP server, Apache/etc
role :app, "89.111.24.210"                          # This may be the same as your `Web` server
role :db,  "89.111.24.210", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

after "deploy", "deploy:bundle_gems"
after "deploy:bundle_gems", "deploy:restart"

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :bundle_gems do
       run "cd #{deploy_to}/current && bundle install vendor/gems"
  end
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run  "touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
