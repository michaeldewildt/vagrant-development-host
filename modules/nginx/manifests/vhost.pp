define nginx::vhost(
  $framework = $nginx::framework,
){

  include nginx
  
  file { "/home/${name}":
     ensure => directory,
     before => File ["/etc/nginx/sites-available/${name}"],
     require => Package["nginx"],
  }
  
  file { "/etc/nginx/sites-available/${name}":
    content => template("nginx/${framework}.erb"),
    before => File["/etc/nginx/sites-enabled/default"],
  }
  
  file { "/etc/nginx/sites-enabled/${name}":
    ensure => link,
    target => "/etc/nginx/sites-available/${name}",
    before => File['/etc/nginx/sites-enabled/default'],
  }  
}