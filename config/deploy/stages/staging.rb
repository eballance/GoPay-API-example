set :user, "www-gopay-example-stg"
set :domain, "gopay.defactory.net"
set :is_root_domain, false
set :root_domain, ""

set :deploy_to, "/home/web/#{domain}"

# Roles
role :app, "#{machine}"
role :web, "#{machine}"
role :db, "#{machine}", :primary => true