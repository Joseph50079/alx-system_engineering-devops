# 100-puppet_ssh_config.pp

# Ensure the presence of the 'file_line' resource type from the puppetlabs-stdlib module
# If you haven't already, you need to install the stdlib module by running:
# sudo puppet module install puppetlabs-stdlib

# Turn off password authentication
file_line { 'Turn off passwd auth':
  path  => '/etc/ssh/sshd_config',
  line  => 'PasswordAuthentication no',
  match => '^#?PasswordAuthentication.*',
}

# Declare identity file
file_line { 'Declare identity file':
  path  => '/etc/ssh/ssh_config',
  line  => 'IdentityFile ~/.ssh/id_rsa',
  match => '^#?IdentityFile.*',
}
