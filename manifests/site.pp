node 'slave1.puppet' {
   package { 'php':
    ensure => installed, 
            }
  package { 'httpd':
    ensure => installed, 
            }

  file { '/var/www/html/index.php':
         ensure => file,
         source => 'https://raw.githubusercontent.com/serggarant/puppet_conf/production/files/index.php',
         replace => false,
         notify => Service['httpd']
          }
  file {'/root/README':
      ensure => absent,
       }
      service {'httpd':
        ensure=> running,
        
      }  
                    }
  
node 'slave2.puppet'{
    class {'apache':
    default_vhost => false, 
          }
      apache::vhost{'serg':
            port    => '81',
            docroot    => '/var/www/html',
             }
    file { '/var/www/html/index.html':
         ensure => file,
         source => 'https://raw.githubusercontent.com/serggarant/puppet_conf/production/files/index.html',
         replace => false,
         notify => Service['httpd']
        file {'/root/README':
         ensure => absent,
         }
             }
node 'master.puppet' {
class { "nginx": }
   nginx::resource::server { 'serg':
    listen_port => 81,
    proxy       => 'slave2.puppet:81',
}
 }

      
  
