class cron-puppet {
    file { 'post-hook':
        ensure  => file,
        path    => '/etc/puppet/.git/hooks/post-merge',
        source  => 'puppet:///modules/cron-puppet/post-merge',
        mode    => 0755,
        owner   => root,
        group   => root,
    }
    cron { 'puppet-apply':
        ensure  => present,
        command => "cd /etc/puppet ; /usr/bin/git pull",
        user    => root,
        minute  => '*/30',
        require => File['post-hook'],
    }
    file { 'post-hook':
        ensure  => file,
        path    => '/var/lib/puppet_practice.txt',
        content  => 'This is puppet practice test file',
        mode    => 0755,
        owner   => root,
        group   => root,
    }
}
