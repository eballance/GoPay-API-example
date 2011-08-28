set :user, "www-prestavby"
set :domain, "gopay.defactory.net"
set :is_root_domain, true
set :root_domain, "gopay.defactory.net"

set :deploy_to, "/home/web/#{domain}"

# Roles
role :app, "#{machine}"
role :web, "#{machine}"
role :db, "#{machine}", :primary => true