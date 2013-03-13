class hadoop {
  $hadoop_home = "/opt/hadoop"
  $hadoop_ver = "0.20.2"

  exec { "download_hadoop":
    command => "wget -O /tmp/hadoop.tgz http://archive.apache.org/dist/hadoop/core/hadoop-${hadoop_ver}/hadoop-${hadoop_ver}.tar.gz",
    path => $path,
    unless => "ls /opt | grep hadoop-${hadoop_ver}",
    require => Package["openjdk-7-jdk"]
  }

  exec { "unpack_hadoop":
    command => "tar -xzf /tmp/hadoop.tgz -C /opt",
    path => $path,
    creates => "${hadoop_home}-${hadoop_ver}",
    require => Exec["download_hadoop"]
  }

  exec { "symlink_hadoop":
    command => "mkdir -p /opt/hadoop_install; ln -s ${hadoop_home}-${hadoop_ver} /opt/hadoop_install/hadoop",
    path => $path,
    creates => "/opt/hadoop_install/hadoop",
    require => Exec["unpack_hadoop"]
  }

  exec { "logs":
    command => "mkdir -p ${hadoop_home}-${hadoop_ver}/logs; chmod 0777 ${hadoop_home}-${hadoop_ver}/logs",
    path => $path,
    creates => "/opt/hadoop_install/hadoop/logs",
    require => Exec["unpack_hadoop"]
  }

  exec { "tmp":
    command => "mkdir -p ${hadoop_home}-${hadoop_ver}/tmp; chmod 0777 ${hadoop_home}-${hadoop_ver}/tmp",
    path => $path,
    creates => "/opt/hadoop_install/hadoop/tmp",
    require => Exec["unpack_hadoop"]
  }

  file { "${hadoop_home}-${hadoop_ver}/conf/hadoop-env.sh":
    source => "puppet:///files/modules/hadoop/conf/hadoop-env.sh",
    mode => 644,
    owner => root,
    group => root,
    require => Exec["unpack_hadoop"],
  }

  file { "${hadoop_home}-${hadoop_ver}/conf/core-site.xml":
    source => "puppet:///files/modules/hadoop/conf/core-site.xml",
    mode => 644,
    owner => root,
    group => root,
    require => Exec["unpack_hadoop"],
  }

  file { "${hadoop_home}-${hadoop_ver}/conf/hdfs-site.xml":
    source => "puppet:///files/modules/hadoop/conf/hdfs-site.xml",
    mode => 644,
    owner => root,
    group => root,
    require => Exec["unpack_hadoop"],
  }

  file { "${hadoop_home}-${hadoop_ver}/conf/mapred-site.xml":
    source => "puppet:///files/modules/hadoop/conf/mapred-site.xml",
    mode => 644,
    owner => root,
    group => root,
    require => Exec["unpack_hadoop"],
  }
}
