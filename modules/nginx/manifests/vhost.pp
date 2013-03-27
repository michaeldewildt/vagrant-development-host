define nginx::vhost(
  $framework = $nginx::framework,
  $is_local_deploy = $nginx::is_local_deploy,
){

  include nginx
  
  if $is_local_deploy == 'false' {
    file { "/home/${name}":
       ensure => directory,
       before => File ["/etc/nginx/sites-available/${name}"],
       require => Package["nginx"],
    }
  } else {

    file { "/home/capifony/${name}":
       ensure => directory,
       before => File ["/etc/nginx/sites-available/${name}"],       
       require => Package["nginx"],
       owner  => "vagrant",
       group  => "vagrant",
    }

    file { "/home/${name}":
       ensure => link,
       before => File ["/etc/nginx/sites-available/${name}"],       
       require => Package["nginx"],
       target => "/home/capifony/${name}/current",
       owner  => "vagrant",
       group  => "vagrant",
    }
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
