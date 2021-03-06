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
gem_package	'rails'
gem_package	'unicorn'

# Nginx Server Configuration
apt_package 'nginx'
cookbook_file "nginx-default" do
  path "/etc/nginx/sites-available/default"
end

  # Final bundle update
execute 'update all bundle' do
  command   'bundle install'
  cwd       app_dir
  user      "ubuntu"
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
  user      'ubuntu'
end

# start up unicorn
execute 'start unicorn' do
	command 	'bundle exec unicorn -c config/unicorn.rb -E production -D'
	cwd       app_dir
	user      'ubuntu'
end
# reload nginx
service "nginx" do
  action  :restart
end
