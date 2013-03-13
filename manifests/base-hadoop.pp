include hadoop

group { "puppet":
  ensure => "present",
}

exec { "apt-get update":
  path => ["/bin", "/usr/bin"],
  command => "apt-get update",
}

package { "openjdk-7-jdk":
  ensure => present,
  require => Exec["apt-get update"],
}

file { "/etc/sysctl.conf":
  source => "puppet:///files/modules/hadoop/etc/sysctl.conf",
  mode => 0644,
  owner => root,
  group => root,
  require => Exec["apt-get update"],
}

file { "/home/vagrant/.bashrc":
  source => "puppet:///files/modules/hadoop/bashrc",
  mode => 644,
  owner => vagrant,
  group => vagrant,
  require => Exec["apt-get update"],
}

