# configuring ssh with puppe

# ssh_client_config.pp

node 'default' {
  $ssh_config_path = '/etc/ssh/ssh_config'
  $private_key_path = '~/.ssh/school'

  # Ensure the ssh_config file exists with the desired content and correct permissions
  file { $ssh_config_path:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  # Use augeas to edit the ssh_config file
  augeas { 'ssh_config':
    context => '/files/etc/ssh/ssh_config',
    changes => [
      'set Host/*/IdentityFile $private_key_path',
      'set Host/*/PasswordAuthentication no',
    ],
    onlyif  => 'match Host/*/IdentityFile[.="~/.ssh/school"] size == 0',
  }
}
