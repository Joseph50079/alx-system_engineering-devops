#setup web server
class custom_http_header {
  $hostname = $facts['networking']['hostname']

  # Ensure the necessary packages are installed
  package { 'nginx':
    ensure => installed,
  }

  # Ensure the directory for the HTML file exists
  file { '/var/www/html':
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data',
    mode   => '0755',
  }

  # Create the HTML file with the "Hello World!" content
  file { '/var/www/html/index.html':
    ensure  => file,
    content => 'Hello World!',
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0644',
  }

  # Get the hostname and configure the Nginx server block
  exec { 'configure_nginx':
    path    => '/usr/bin/',
    command => "printf '%s\\n''server {
    listen 80;
    listen [::]:80 default_server;
    root   /var/www/html;
    index  index.html index.htm;

    location / {
        add_header X-Served-By '${hostname}';
    }
}
' > /etc/nginx/sites-available/default",
    require => Package['nginx'],
  }

  # Ensure the Nginx service is running and restart if necessary
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => Exec['configure_nginx'],
  }

}

# Include the custom_http_header class
include custom_http_header
