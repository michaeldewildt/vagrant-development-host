# Basic Puppet PHP manifest

class php {

  Package { ensure => "installed" }

  package { "php5-mysql": } 
  package { "php5-xdebug": }
  package { "php5-intl": }


}

