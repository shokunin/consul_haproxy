# consul_haproxy::configure setup
class consul_haproxy::configure inherits consul_haproxy {

  # I would not do this in production
  File {
    require => Class['consul_haproxy::packages'],
    notify  => Class['consul_haproxy::services'],
  }

  file { '/etc/default/haproxy':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => "ENABLED=1\n",
  }

  file { '/etc/haproxy/haproxy.ctmpl':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('consul_haproxy/haproxy.ctmpl.erb'),
  }

  file { '/etc/init/consul-template.conf':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/consul_haproxy/consul-template-init.conf',
  }
  
  
}
