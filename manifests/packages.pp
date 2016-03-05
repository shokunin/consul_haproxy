# consul_haproxy::packages setup
class consul_haproxy::packages inherits consul_haproxy{

  include staging
  include ubuntu_pkgs

  $bin_dir = '/usr/local/bin'
  $os = downcase($::kernel)
  $download_url = "https://releases.hashicorp.com/consul-template/${version}/consul-template_${version}_${os}_${::architecture}.zip"

  apt::source { 'haproxy-ppa':
    location   => 'http://ppa.launchpad.net/vbernat/haproxy-1.5/ubuntu ',
    repos      => 'main',
    key        => 'CFFB779AADC995E4F350A060505D97A41C61B9CD',
    key_server => 'pgp.mit.edu',
    require    => Class['ubuntu_pkgs']
  }

  package { 'haproxy':
    ensure  => present,
    require => Apt::Source['haproxy-ppa'],
  }

  staging::file { "consul-template-${version}.zip":
    source  => $download_url
    require => Class['ubuntu_pkgs']
  } ->
  staging::extract { "consul-template-${version}.zip":
    target  => $bin_dir,
    creates => "${bin_dir}/consul-template",
  } ->
  file { "${bin_dir}/consul-template":
    owner => 'root',
    group => 0,
    mode  => '0555',
  }

  
}
