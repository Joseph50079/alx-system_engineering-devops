#setup web server
package { 'nginx':
  ensure   => 'installed',
  provider => 'apt',
  name     => 'nginx',
}
exec { 'write file':
  path    => '/usr/bin/',
  command => 'echo "Hello World!" | sudo tee /var/www/html/index.html',
  creates => '/var/www/html/',
}

file { '/var/www/html/index.html' :
  content => 'Hello World!',
}
file_line { 'add header' :
  ensure => present,
  path   => '/etc/nginx/sites-available/default',
  line   => "\tadd_header X-Served-By ${hostname};",
  after  => 'server_name _;',
}

service { 'nginx':
  ensure => running,
}
