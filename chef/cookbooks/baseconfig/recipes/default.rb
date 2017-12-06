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

app_dir = "/home/ubuntu/project"

apt_package 'build-essential'
# PostgreSQL Packages
apt_package %w(postgresql postgresql-contrib libpq-dev)
# Ruby Packages
apt_package %w(ruby-full nodejs libxslt1-dev libxml2-dev)

# Rails Configuration
gem_package 'bundler'
gem_package 'rails'
gem_package 'unicorn'
cookbook_file "unicorn_CMPT470Project" do
  mode    "0755"
  path    "/etc/init.d/unicorn_CMPT470Project"
end

# Nginx Server Configuration
package 'nginx'
cookbook_file "nginx-default" do
  path "/etc/nginx/sites-available/default"
end

# database Configuraion

execute 'run rake job' do
  command 'RAILS_ENV=production rake fetch_api:seed_db'
  cwd '/home/ubuntu/project/'
  user 'ubuntu'
end
  # Final bundle update
execute 'update all bundle' do
  command   'bundle install'
  cwd       app_dir
  user      "ubuntu"
end

execute 'get_js' do
  command 'rails g gmaps4rails:copy_coffee'
end

# Database Configuraion
execute 'add whenever job to cron' do
  command   'RAILS_ENV=production whenever --update-crontab'
  cwd       app_dir
  user      'ubuntu'
end

execute 'migration' do
  command   'RAILS_ENV=production rake db:migrate'
  cwd       app_dir
  user      'ubuntu'
end

# Precompile assets
execute 'precompile asset' do
  command   'RAILS_ENV=production rake assets:precompile'
  cwd       app_dir
  user      "ubuntu"
end

# start up unicorn
execute 'unicorn_CMPT470Project' do
  command   'sudo update-rc.d unicorn_CMPT470Project defaults'
end
service 'unicorn_CMPT470Project' do
  action :start
end
# reload nginx
service "nginx" do
  action  :restart
end
