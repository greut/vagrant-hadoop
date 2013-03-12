class hadoop {
  $hadoop_home = "/opt/hadoop"

  exec { "download_hadoop":
    command => "wget -O /tmp/hadoop.tgz http://mirror.switch.ch/mirror/apache/dist/hadoop/common/hadoop-0.23.6/hadoop-0.23.6.tar.gz",
    path => $path,
    unless => "ls /opt | grep hadoop-0.23.6",
    require => Package["openjdk-6-jdk"]
  }

  exec { "unpack_hadoop":
    command => "tar -xzf /tmp/hadoop.tgz -C /opt",
    path => $path,
    creates => "${hadoop_home}-0.23.6",
    require => Exec["download_hadoop"]
  }

  file { "${hadoop_home}-0.23.6/conf":
    ensure => directory,
    before => File["${hadoop_home}-0.23.6/conf/hadoop-env.sh"],
  }

  file { "${hadoop_home}-0.23.6/conf/hadoop-env.sh":
    source => "puppet:///files/modules/hadoop/conf/hadoop-env.sh",
    mode => 644,
    owner => root,
    group => root,
    require => Exec["unpack_hadoop"],
  }

  file { "${hadoop_home}-0.23.6/conf/core-site.xml":
    source => "puppet:///files/modules/hadoop/conf/core-site.xml",
    mode => 644,
    owner => root,
    group => root,
    require => Exec["unpack_hadoop"],
  }

  file { "${hadoop_home}-0.23.6/conf/hdfs-site.xml":
    source => "puppet:///files/modules/hadoop/conf/hdfs-site.xml",
    mode => 644,
    owner => root,
    group => root,
    require => Exec["unpack_hadoop"],
  }

  file { "${hadoop_home}-0.23.6/conf/mapred-site.xml":
    source => "puppet:///files/modules/hadoop/conf/mapred-site.xml",
    mode => 644,
    owner => root,
    group => root,
    require => Exec["unpack_hadoop"],
  }
}
