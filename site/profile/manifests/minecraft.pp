class profile::minecraft {

file {'/eula.txt':
      ensure => present,
       content => "eula=true"         
      }
       
class { 'java' :
  package => 'java-1.8.0-openjdk-devel',
      }
      
  package { 'jdk-16.0.1-2000:16.0.1-ga.x86_64':
  provider => 'rpm',
  ensure => present,
  source => 'https://files01.tchspt.com/storage2/temp/jdk-16.0.1_linux-x64_bin.rpm',
           }


class { 'archive':
  archives => { '/opt/minecraft/server.jar' => {
                  'ensure' => 'present',
                  'source'  => 'https://launcher.mojang.com/v1/objects/0a269b5f2c5b93b1712d0f5dc43b6182b9ab254e/server.jar',
                                               }  
               }
       }
 file {'/etc/systemd/system/minecraft.service':
      ensure => present,
      mode => "0664",
      content => "[Unit]
                  Description=Foo
                  [Service]
                  ExecStart= java -Xmx1024M -Xms1024M -jar /opt/minecraft/server.jar nogui
                  [Install]
                  WantedBy=multi-user.target",
         }            
   ~> service {'minecraft':
     ensure    => 'running',
     enable => 'true',
              }
}
