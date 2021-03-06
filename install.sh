#!/bin/bash

# We use es 5.x because there is an issue with Kakfa streams connector for es v 6.x
echo 'deb https://artifacts.elastic.co/packages/5.x/apt stable main' | tee -a /etc/apt/sources.list.d/elastic-5.x.list
echo 'deb https://packagecloud.io/grafana/stable/debian/ jessie main' | tee -a /etc/apt/sources.list.d/grafana.list
add-apt-repository 'deb [arch=amd64] https://packages.confluent.io/deb/4.0 stable main'
curl https://packages.confluent.io/deb/4.0/archive.key | apt-key add -
curl https://packagecloud.io/gpg.key | apt-key add -
curl https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
apt -y update
apt -y upgrade
apt -y install openjdk-8-jre-headless
apt -y install confluent-platform-oss-2.11
apt -y install elasticsearch
apt -y install grafana
systemctl enable elasticsearch
systemctl start elasticsearch
systemctl enable grafana-server
systemctl start grafana-server

# Start the confluent services
confluent start


# Install a local copy of ksql
wget https://github.com/confluentinc/ksql/releases/download/v0.4/ksql-0.4.tgz
tar xf ksql-0.4.tgz  -C /root
/root/ksql/bin/ksql-server-start -daemon /root/ksql.properties
