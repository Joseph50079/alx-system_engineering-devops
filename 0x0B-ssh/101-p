# configuring ssh with puppe


  # Use augeas to edit the ssh_config file
  augeas { 'ssh_config':
    context => '/files/etc/ssh/ssh_config',
    changes => [
      'set Host/*/IdentityFile $private_key_path',
      'set Host/*/PasswordAuthentication no',
    ],
    onlyif  => 'match Host/*/IdentityFile[.="~/.ssh/school"] size == 0',
  }

