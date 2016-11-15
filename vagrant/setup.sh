#!/bin/bash

# use gem in rbenv
export PATH="~/.rbenv/shims:$PATH"
# TODO: check use rbenv7s gem

gem install berkshelf
rbenv rehash

/usr/bin/vagrant plugin install sahara vagrant-berkshelf vagrant-cachier vagrant-omnibus
#/usr/bin/vagrant plugin install sahara
#/usr/bin/vagrant plugin install vagrant-berkshelf
#/usr/bin/vagrant plugin install vagrant-cachier
#/usr/bin/vagrant plugin install vagrant-omnibus

#/usr/bin/vagrant plugin install sahara            --plugin-version 0.0.17
#/usr/bin/vagrant plugin install vagrant-berkshelf --plugin-version 4.0.3
#/usr/bin/vagrant plugin install vagrant-cachier   --plugin-version 1.2.0
#/usr/bin/vagrant plugin install vagrant-omnibus   --plugin-version 1.4.1
