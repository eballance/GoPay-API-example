desc "Remote console" 
task :console, :roles => :app do
  input = ''
  env = ENV['RAILS_ENV'] || "production"
  run "cd #{current_path} && ./script/console #{env}" do |channel, stream, data|
    next if data.chomp == input.chomp || data.chomp == ''
    print data
    channel.send_data(input = $stdin.gets) if data =~ /^(>|\?)>/
  end
end

namespace :usage do
  desc "Show the amount of free disk space."
  task :hdd, :roles => :app do
    run "df -h /"
  end
 
  desc "Show free memory"
  task :memory, :roles => :app do
    run "free -m"
  end
end