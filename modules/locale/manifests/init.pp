class locale {

  file { "/etc/default/locale":
    ensure => present,
    source => "puppet:///modules/locale/locale"
  }
}  