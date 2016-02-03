#!/bin/bash
vagrant plugin install cacheier
vagrant plugin install vagrant-cachier vagrant-global-status vagrant-vbox-snapshot vagrant-serverspec vagrant-vbguest vagrantboxes
vagrant plugin update vagrant-berkshelf --plugin-version 1.3.7
