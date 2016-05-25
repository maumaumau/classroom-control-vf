define users::managed_user (
) {
  user { $title:
  ensure => present,
  }
  file { "/home/${title}":
  ensure => directory,
  owner => $title,
  group => $group,
  }
  file { "/home/${title}/.ssh":
  ensure => directory,
  owner => $title,
  group => $group,
  chmod => '0700',
  }
}
