# installing sun jre 

class update-sun-jre {

  Package { ensure => "installed" }

  package { "update-sun-jre": }
  
  exec { 'java_to_sources_list':
    command => 'echo "deb http://www.duinsoft.nl/pkg debs all" >> /etc/apt/sources.list',
    path => '/bin/'
  }
  
  exec { 'apt_key_for_java':
    command => 'apt-key adv --keyserver keys.gnupg.net --recv-keys 5CB26B26',
    path => '/bin/:/usr/bin/'
  }

  Exec['java_to_sources_list'] -> Exec['apt_key_for_java'] -> Exec['apt-get update'] -> Package['update-sun-jre']
}
