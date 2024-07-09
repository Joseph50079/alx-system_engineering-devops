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

file {'/etc/nginx/sites-available/default':
  content => 'server {
    listen 80;
    listen [::]:80 default_server;
    root   /var/www/html;
    index  index.html index.htm;

    location / {
        add_header X-Served-By "$(hostname)";
    }
}',
}

service { 'nginx':
  ensure => running,
}
