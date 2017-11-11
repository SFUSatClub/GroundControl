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
package "git-core"
package "curl"
package "zlib1g-dev"
package "build-essential"
package "libssl-dev"
package "libreadline-dev"
package "libyaml-dev"
package "libsqlite3-dev"
package "sqlite3"
package "libxml2-dev"
package "libxslt1-dev"
package "libcurl4-openssl-dev"
package "python-software-properties"
package "libffi-dev"
package "nodejs"
package "libgdbm-dev"
package "libncurses5-dev"
package "automake"
package "libtool"
package "bison"
package "libffi-dev"
package "postgresql"
package "postgresql-contrib"
package "libpq-dev"

execute 'install ruby' do
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
  command 'sudo echo "gem: --no-ri --no-rdoc" > ~/.gemrc'
end

execute 'bundle' do
  command 'bundle install'
  cwd '/home/ubuntu/project/'
  user 'ubuntu'
end

execute 'create postgres user' do
  command 'sudo -u postgres createuser ubuntu -s'
end

execute 'create databases and migrate' do
  command 'rake db:drop db:create db:migrate'
  cwd '/home/ubuntu/project/'
  user 'ubuntu'
end

execute 'start server' do
  command 'rails s -d -b 0.0.0.0'
  cwd '/home/ubuntu/project/'
  user 'ubuntu'
end