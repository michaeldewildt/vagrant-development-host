# installing java and elasticsearch

class elasticsearch {

#sudo sh -c "echo 'deb http://www.duinsoft.nl/pkg debs all' >> /etc/apt/sources.list"
#sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 5CB26B26
#sudo apt-get update
#sudo apt-get install update-sun-jre

#.bash_profile:
#export JAVA_HOME=/usr/bin/java
#export PATH=$PATH:/usr/bin/java

#wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.20.6.tar.gz
#tar xfz elasticsearch-0.20.6.tar.gz
#cd elasticsearch-0.20.6/bin
#bash elasticsearch

  exec { 'wget_for_elasticsearch':
    command => 'wget -O /vagrant/elasticsearch-0.20.6.tar.gz https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.20.6.tar.gz',
    path => '/usr/bin/'
  }

  exec { 'untar_elasticsearch':
    command => 'tar xfz /vagrant/elasticsearch-0.20.6.tar.gz -C /vagrant/elasticsearch-0.20.6',
    path => '/bin/'
  }

  exec {'elasticsearch_run':
    command => 'elasticsearch &',
    path => '/vagrant/elasticsearch-0.20.6/bin/'
  }
 
  Package['update-sun-jre'] -> Exec['wget_for_elasticsearch'] -> Exec['untar_elasticsearch']
}

