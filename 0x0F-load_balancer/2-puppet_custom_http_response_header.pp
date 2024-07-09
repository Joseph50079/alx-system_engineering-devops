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
###file_line { 'add header' :
  ensure => present,
  path   => '/etc/nginx/sites-available/default',
  line   => "\tadd_header X-Served-By ${hostname};",
  after  => 'server_name _;',
}###

file {'/etc/nginx/sites-available/default':
	content => "server {
    listen 80;
    listen [::]:80 default_server;
    root   /var/www/html;
    index  index.html index.htm;

    location / {
        add_header X-Served-By "$HOSTNAME";
    }
}',
}

service { 'nginx':
  ensure => running,
}
