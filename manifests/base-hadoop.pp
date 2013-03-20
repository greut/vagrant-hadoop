 # -*- mode: ruby -*-
# vi: set ft=ruby nowrap sw=2 sts=2 ts=8 noet:
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

file { "/home/vagrant/.ssh/id_rsa":
  source => "puppet:///files/modules/hadoop/id_rsa",
  mode => 600,
  owner => vagrant,
  group => vagrant,
  require => Exec["apt-get update"]
}

file { "/home/vagrant/.ssh/id_rsa.pub":
  source => "puppet:///files/modules/hadoop/id_rsa.pub",
  mode => 600,
  owner => vagrant,
  group => vagrant,
  require => Exec["apt-get update"]
}

ssh_authorized_key { "ssh_key":
  ensure => "present",
  key => "AAAAB3NzaC1kc3MAAACBAJwPhAh1co94qv4r/HRqB8eOUQ1JWwuPxnGPrfz2ZMSfFGGKW+khRmHS8sd9gME6laXN7W3Sl/kvY8tHkqmPNHhOkhPZYD2TFtjBZAOeO7mhmWVsxoyf6qacoL2iXjuzRrGtGmLek7hvHkcn4brg0Pkl81FT2N1mnjhvNoeDHqLBAAAAFQDtYHvtHlP+z1rCNmqvnS1GqVX8OwAAAIBQfZLQ2VqR0lUY1XOEAkpsSH1eu5J8rjL7OTe0eDCebQ6RSVzHE2VsQnvjAFDtV2e13c+PR4tCdSgeK/xrhbt267221YXEk8y49nIV9AIBQz5r/cQgexpiD0ZN/R8xGKzUt/oh2NItqtupgtwmGEpW3ee5v66C0SBhZD52TdSYJwAAAIBX24R9amziYb7n7jX64TDMTNcV0cMp2NTGMatQ94CRBLF2Z3Qk/UcJP+j+HsebCszX5ry92akzq38wP3hYNYfHJHJ5u5FdbSzeZmgLcMArF2eIxONKrvoMpguE1y8t4ELr6yVViIMje9Mra2nxElXqMVza5FwcNCPXbdQZiws6sQ==",
  type => "ssh-dss",
  user => "vagrant",
  require => File["/home/vagrant/.ssh/id_rsa.pub"]
}
