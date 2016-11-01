#!/bin/sh
sudo su
apt-get update ; sudo apt-get upgrade -y ; sudo apt-get install git -y;
#tdagent
curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-trusty-td-agent2.sh | sh
/etc/init.d/td-agent restart
/etc/init.d/td-agent status
#!/bin/sh
#tdagent
curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-trusty-td-agent2.sh | sh
sudo td-agent-gem install fluent-plugin-elasticsearch
/etc/init.d/td-agent restart
/etc/init.d/td-agent status

echo "
<source>
 @type syslog
 port 5140
 tag  syslog
</source>

<source>
 @type forward
</source>

<match syslog.*.*>
 @type elasticsearch
 logstash_format true
 flush_interval 10s
</match>
" > /etc/td-agent/td-agent.conf

echo "
index.code: best_compression
" >> /etc/elasticsearch/elasticsearch.yml




#java
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get -y install oracle-java8-installer
#elasticsearch 
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
sudo apt-get update && sudo apt-get install elasticsearch -y 
sudo update-rc.d elasticsearch defaults 95 10
sudo /etc/init.d/elasticsearch start
sudo /etc/init.d/elasticsearch status
#kibana 
wget https://download.elastic.co/kibana/kibana/kibana-4.5.1-linux-x64.tar.gz
tar xfvz kibana-4.5.1-linux-x64.tar.gz
./kibana-4.5.1-linux-x64/bin/kibana -p 80&
sleep 10 
curl -XGET http://localhost:9200

