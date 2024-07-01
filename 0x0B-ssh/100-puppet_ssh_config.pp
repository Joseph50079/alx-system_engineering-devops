# configuring ssh with puppet

augeas {'ssh_config':
	context	=> '/etc/ssh/ssh-config',
	changes => [
		'set PasswordAuthentication no',
		'set IdentifyFiles ~/.ssh/school',
		],
	}
