class nginx {

package { 'nginx':
  ensure => present,
}

File {
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0664',
  }
  
file { '/etc/nginx/nginx.conf':
  source  => 'puppet:///modules/nginx/nginx.conf',
  require => Package['nginx'],
}

file { '/var/www':
  ensure  => directory,
  mode    => '0775',
  require => Package['nginx'],
}

file { '/var/www/index.html':
  source  => 'puppet:///modules/nginx/index.html',
  require => Package['nginx'],
}

file { '/etc/nginx/conf.d/default.conf':
  source  => 'puppet:///modules/nginx/default.conf',
  require => Package['nginx'],
}

service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => [ File['/etc/nginx/nginx.conf'], File['/etc/nginx/conf.d/default.conf'] ],

}

}
