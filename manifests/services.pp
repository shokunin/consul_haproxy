# consul_haproxy::services setup
class consul_haproxy::services{

  service { 'haproxy' :
    ensure  => running,
    enable  => true,
    require => Class['consul_haproxy::packages'],
  }

  service { 'consul-template' :
    ensure  => running,
    enable  => true,
    require => Class['consul_haproxy::packages'],
  }
  
}
