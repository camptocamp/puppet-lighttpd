/*

== Class lighttpd

Install and create puppet resources for lighttpd.

Example:

node 'foo.bar' {
  include lighttpd
  class { '::lighttpd::administration':
    sudo_user => 'foo',
  }

  lighttpd::vhost {$::fqdn:
    ensure  => present,
    aliases => ['bar.foo'],
  }
}

*/
class lighttpd {
  case $::osfamily {
    'Debian': { include ::lighttpd::debian }
    'RedHat': { include ::lighttpd::redhat }
    default: { fail "No instruction for ${::osfamily}" }
  }
}
