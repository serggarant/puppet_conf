node default {
}

node 'slave1.puppet' {
   class { 'apache': }
   
   file { '/root/README':
      ensure => absent,
      }
   
   file { '/var/www/html/index.html':
      ensure => file,
      source => 'https://raw.githubusercontent.com/serggarant/puppet_conf/production/files/index.html',
      replace => false,
      }
}

node 'slave2.puppet' {
   class { 'apache::mod::php': }
   
   class { 'php': }
   
   file { '/root/README':
      ensure => absent,
      }
   
   file { '/var/www/html/index.php':
      ensure => file,
      source => 'https://raw.githubusercontent.com/serggarant/puppet_conf/production/files/index.php',
      replace => false,
      }
      
   file { '/etc/httpd/conf.d/web.conf':
      ensure => file,
      source => 'https://raw.githubusercontent.com/serggarant/puppet_conf/production/files/web.conf',
      replace => false,
      } 
      
    file { '/etc/httpd/conf.d/welcome.conf':
      ensure => absent,
      } 
      
    exec {"list 81 port":
      command => 'sudo sed -i '/Listen 80/a Listen 81' /etc/httpd/conf/httpd.conf',
      provider => shell,
      }
}
