namespace :deploy do
  desc "Restarting Passenger"
  task :restart, :roles => :app do
    HIT_URL = "onetwo.irenajuzova.cz"
    run "touch #{deploy_to}/current/tmp/restart.txt"
    #  && curl -s -I #{HIT_URL} | grep '200 OK'
  end
end