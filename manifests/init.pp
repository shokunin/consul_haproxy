# Init for consul_haproxy
class consul_haproxy (
                        $version = '0.13.0',
                        $port = '3000',
                        $service_tag = 'public-web-service'
                      ) {
  include consul_haproxy::packages
  include consul_haproxy::configure
  include consul_haproxy::services
}
