node 'slave1.puppet' {
   class { 'apache':}
   
   file { '/root/README':
      ensure => absent,
      }
   
   file { '/var/www/html/index.html':
      ensure => file,
      source => 'https://raw.githubusercontent.com/serggarant/puppet_conf/production/files/index.html',
      replace => false,
      }
}

class { 'apache::mod::php':}
   apache::vhost{'web':
            port    => '81',
            docroot    => '/var/www/html',
             }
   package { 'php':
    ensure => installed, 
            } 
                 
   
   file { '/var/www/html/index.php':
      ensure => file,
      source => 'https://raw.githubusercontent.com/serggarant/puppet_conf/production/files/index.php',
      replace => false,
      }
      
   file {'/root/README':
      ensure => absent,
         }       
}
