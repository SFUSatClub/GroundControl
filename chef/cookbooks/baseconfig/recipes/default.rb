# Make sure the Apt package lists are up to date, so we're downloading versions that exist.
cookbook_file "apt-sources.list" do
  path "/etc/apt/sources.list"
end
execute 'apt_update' do
  command 'apt-get update'
end

# Base configuration recipe in Chef.
package "wget"
package "ntp"
cookbook_file "ntp.conf" do
  path "/etc/ntp.conf"
end
execute 'ntp_restart' do
  command 'service ntp restart'
end

# Rails setup
package "ruby-dev"
package "zlib1g-dev"
package "nodejs"

execute 'install rails dependencies' do
  command 'apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs -y'
end

execute 'install ruby' do
  command 'apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev'
  command 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'
  command 'curl -sSL https://get.rvm.io | bash -s stable'
  command 'source ~/.rvm/scripts/rvm'
  command 'rvm install 2.4.2'
  command 'rvm use 2.4.2 --default'
  command 'ruby -v'
end

execute 'get bundler' do
  command 'gem install bundler --conservative'
end

execute 'get rails' do
  command 'gem install rails -v 5.1.4'
end

execute 'get postgresql' do
  command 'apt-get install postgresql postgresql-contrib libpq-dev -y'
end

execute 'bundle' do
  command 'bundle install'
  cwd '/home/ubuntu/project/'
  user 'ubuntu'
end

execute 'create postgres user' do
  command 'sudo -u postgres createuser ubuntu -s'
end

execute 'create databases' do
  command 'rake db:create'
  cwd '/home/ubuntu/project/'
  user 'ubuntu'
end

execute 'migration' do
  command 'rake db:migrate'
  cwd '/home/ubuntu/project/'
  user 'ubuntu'
end

execute 'start server' do
  command 'rails s -d -b 0.0.0.0'
  cwd '/home/ubuntu/project/'
  user 'ubuntu'
end