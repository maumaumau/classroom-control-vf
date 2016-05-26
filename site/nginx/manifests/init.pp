class nginx {

$pkg = 'nginx'


File {
  ensure  => file,
    owner   => 'root',
      group   => 'root',
        mode    => '0664',
          }

package { "$pkg":
  ensure => present,
  }

file { '/etc/nginx/nginx.conf':
  source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package["$pkg"],
    }

file { '/var/www':
  ensure  => directory,
    mode    => '0775',
      require => Package["$pkg"],
      }

file { '/var/www/index.html':
  source  => 'puppet:///modules/nginx/index.html',
    require => Package["$pkg"],
    }

file { '/etc/nginx/conf.d/default.conf':
  source  => 'puppet:///modules/nginx/default.conf',
    require => Package["$pkg"],
    }

service { 'nginx':
  ensure    => running,
    enable    => true,
      subscribe => [ File['/etc/nginx/nginx.conf'], File['/etc/nginx/conf.d/default.conf'] ],

}

}
