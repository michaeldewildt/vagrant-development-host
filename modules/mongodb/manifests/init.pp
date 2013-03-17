class mongodb {

  package { 'mongodb-10gen': }
  
  exec { 'add_key_for_mongodb': 
    command => 'sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10',
    before => Exec['apt-get update'],
    path => '/usr/bin:/bin:/usr/sbin:/sbin'
  }

  file { "/etc/apt/sources.list.d/10gen.list":
    source => 'puppet:///modules/mongodb/10gen.list',
    before => Exec['add_key_for_mongodb'],
  }
  
  file { "/etc/php5/conf.d/20-mongo.ini":
    ensure => link,
    target => "/etc/php5/mods-available/mongo.ini",
  }
  
  Package <| |> -> File["/etc/php5/conf.d/20-mongo.ini"]
  
}  