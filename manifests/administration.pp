/*

== Class: lighttpd::administration

Create a new group, and add new rights to sudoers

=== Parameters
- *$sudo_user*: can be either a group, a user, or a mix

=== Requires
- Class['lighttpd']

=== Example

    node 'foo.bar' {
      include ::lighttpd
      class {'::lighttpd::administration':
        sudo_user => '%mygroup, someuser',
      }

*/
class lighttpd::administration (
  $sudo_user = $sudo_lighttpd_admin_user,
) {

  group {'lighttpd-admin':
    ensure => present,
    system => true,
  }

  $sudo_group = '%lighttpd-admin'
  $sudo_user_alias = flatten([$sudo_group, $sudo_user])
  $sudo_cmnd = '/etc/init.d/lighttpd, /usr/sbin/lighttpd-angel, /bin/su www-data, /bin/su - www-data'

  sudo::conf {'lighttpd':
    ensure  => present,
    content => template('lighttpd/lighttpd-sudoers.erb'),
    require => Group['lighttpd-admin'],
  }
}
