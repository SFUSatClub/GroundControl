# Make sure the Apt package lists are up to date, so we're downloading versions that exist.
cookbook_file "apt-sources.list" do
  path "/etc/apt/sources.list"
end
execute 'apt_update' do
  command 'apt-get update'
end

# Base configuration recipe in Chef.
package "wget"
package "curl"
package "ntp"
cookbook_file "ntp.conf" do
  path "/etc/ntp.conf"
end
execute 'ntp_restart' do
  command 'service ntp restart'
end

    # My Configuration

# PostgreSQL Configuration

package 'postgresql'
package 'postgresql-contrib'
package 'libpq-dev'

# execute "create postgres user" do
#   ignore_failure true
#   command 'sudo -u postgres createuser ubuntu -s'
# end

# Ruby Configuration
package 'build-essential'
package 'ruby-full'
package 'nodejs'
package 'libxslt1-dev'
package 'libxml2-dev'


execute 'install bundle' do
  command 'gem install bundler --conservative'
end

# rails Configuration

execute 'install rails' do
  command 'gem install rails -- --use-system-libraries --with-xml2-include=/usr/include/libxml2 --with-xml2-lib=/usr/lib/ --conservative'
end

# final bundle update
execute 'update bundle' do
  command 'bundle install'
  cwd '/home/ubuntu/project'
  user 'ubuntu'
end

# database Configuraion

# execute 'create database' do
#   command 'rake db:create RAILS_ENV=production'
#   cwd '/home/ubuntu/project'
#   user 'ubuntu'
# end

# execute 'migration' do
#   command 'rake db:migrate RAILS_ENV=production'
#   cwd '/home/ubuntu/project'
#   user 'ubuntu'
# end

execute 'run rake job' do
  command 'RAILS_ENV=production rake fetch_api:seed_db'
  cwd '/home/ubuntu/project/'
  user 'ubuntu'
end

execute 'add whenever job to cron' do
  command 'RAILS_ENV=production whenever --update-crontab'
  cwd '/home/ubuntu/project/'
  user 'ubuntu'
end

# unicorn Configuration

execute 'install unicorn' do
  command 'gem install unicorn --conservative'
end

cookbook_file "unicorn" do
 path "/etc/init.d/unicorn"
end

file '/etc/init.d/unicorn' do
  mode '0755'
  owner 'ubuntu'
end


# start up unicorn

execute 'unicorn_rails' do
  command 'sudo update-rc.d unicorn defaults'
end

service 'unicorn' do
  action :start
end

# nginx Server Configuration

package 'nginx'
cookbook_file "nginx-default" do
  path "/etc/nginx/sites-available/default"
end

service "nginx" do
  action :restart
end

#execute 'start server' do
#  command 'rails s -d -b 0.0.0.0'
#  cwd '/home/ubuntu/project/'
#  user 'ubuntu'
#end
