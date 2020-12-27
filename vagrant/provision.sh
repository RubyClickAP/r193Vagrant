#!/usr/bin/env bash

# Update remote package metadata
apt-get update -q

# Install deb dependencies
apt-get install -f -y git curl libcurl4-openssl-dev wget build-essential subversion autoconf libpq-dev libsqlite3-dev libmysqlclient-dev zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev bison qt4-qmake libqtwebkit-dev libffi-dev net-tools
apt install -y libssl1.0-dev

git clone git://github.com/RubyClickAP/rbenv.git        /opt/.rbenv
# Add rbenv to the path: (²£¥Írbenv.sh)
echo '# rbenv setup' > /etc/profile.d/rbenv.sh
echo 'export RBENV_ROOT=/opt/.rbenv' >> /etc/profile.d/rbenv.sh
echo 'export PATH="$RBENV_ROOT/bin:$RBENV_ROOT/shims:$PATH"' >> /etc/profile.d/rbenv.sh
echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
chmod +x /etc/profile.d/rbenv.sh
source /etc/profile.d/rbenv.sh

git clone https://github.com/RubyClickAP/ruby-build.git /opt/.rbenv/plugins/ruby-build
/opt/.rbenv/plugins/ruby-build/install.sh

curl -fsSL https://gist.github.com/FiveYellowMice/c50490693d47577cfe7e6ac9fc3bf6cf.txt | rbenv install --patch 1.9.3-p551
#rbenv install --patch 1.9.3-p551 # notworking, Test on 27Dec2020
rbenv global 1.9.3-p551
rbenv rehash

sudo -H -u root /bin/bash << 'SCRIPT'
  #export PATH=/opt/rubies/ruby-1.9.3-p547/bin:$PATH
  #source /etc/profile.d/rbenv.sh
  export PATH=/opt/.rbenv/bin:/opt/.rbenv/shims:$PATH
  # Monk & Dependencies
  gem install --no-ri --no-rdoc monk
  # Ruby-Passenger
  gem install --no-ri --no-rdoc bundler -v 1.17.3
  gem install --no-ri --no-rdoc rack -v 1.6.11
  gem install --no-ri --no-rdoc passenger 
  # Other gem
  gem install --no-ri --no-rdoc activesupport -v 4.2.6
  gem install --no-ri --no-rdoc mime-types -v 2.99.3
  gem install --no-ri --no-rdoc unix-crypt -v 1.3.0
  # for resque-1.27.4
  gem install mono_logger --no-ri --no-rdoc  -v 1.1.0 && \
  gem install multi_json --no-ri --no-rdoc  -v 1.11.2 && \
  gem install tilt  --no-ri --no-rdoc -v 1.4.1
  gem install thin --no-ri --no-rdoc
  #gem install unoconv --no-ri --no-rdoc
SCRIPT