node 'default' {} 

node 'slave1.puppet' {
   class { 'apache':}
      file { '/var/www/html/index.html':
      ensure => file,
      source => 'https://raw.githubusercontent.com/serggarant/puppet_conf/production/files/index.html',
      replace => false,
      }
      
      file {'/root/README':
      ensure => absent,
      }
}
node 'slave2.puppet'{
   class { 'apache::mod::php':}
   apache::vhost{'serg':
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
node 'master.puppet' {
   include 'nginx'
      nginx::resource::server { '192.168.3.10':
      listen_port => 82,
      proxy       => 'http://192.168.3.12:81',
      }         
}

node 'minecraft.puppet' {
   include profile::minecraft
}
