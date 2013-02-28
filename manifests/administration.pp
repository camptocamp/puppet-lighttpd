/*

== Class: lighttpd::administration

Create a new group, and add new rights to sudoers

Variables:
- *$sudo_lighttpd_admin_user*: can be either a group, a user, or a mix
- *$sudo_lighttpd_admin_cmnd*: provide some other command for sudo

Requires:
- Class["lighttpd"]

Example:
node "foo.bar" {
  $sudo_lighttpd_admin_user = "%mygroup, someuser"
  include lighttpd
  include lighttpd::administration

*/
class lighttpd::administration {
  
  group {"lighttpd-admin":
    ensure => present,
    system => true,
  }

  sudo::directive {"lighttpd":
    ensure  => present,
    content => template("lighttpd/lighttpd-sudoers.erb"),
    require => Group["lighttpd-admin"],
  }
}
