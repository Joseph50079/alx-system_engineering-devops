# Execute kill process

exec { 'killmenow':
  command => 'pkill killmenow',
  path    => '/usr/bin/',
}
