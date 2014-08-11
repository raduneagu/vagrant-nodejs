class apt_update {
    exec { "aptGetUpdate":
        command => "sudo apt-get update",
        path => ["/bin", "/usr/bin"]
    }
}

class othertools {
    package { "git":
        ensure => latest,
        require => Exec["aptGetUpdate"]
    }

    package { "vim-common":
        ensure => latest,
        require => Exec["aptGetUpdate"]
    }

    package { "curl":
        ensure => present,
        require => Exec["aptGetUpdate"]
    }

    package { "htop":
        ensure => present,
        require => Exec["aptGetUpdate"]
    }

    package { "g++":
        ensure => present,
        require => Exec["aptGetUpdate"]
    }

    include apt
    apt::ppa {
    'ppa:fish-shell/release-2': notify => Package["fish"]
    }

    package { "fish":
        ensure => present,
        require => Exec["aptGetUpdate"]
    }

    user { "vagrant":
      ensure => present,
      shell  => "/usr/bin/fish", # or "/usr/bin/zsh" depending on guest OS (check it by running `which zsh`)
      require => Package['fish']
    }

}

class node-js {
  include apt
  apt::ppa {
    'ppa:chris-lea/node.js': notify => Package["nodejs"]
  }

  package { "nodejs" :
      ensure => latest,
      require => [Exec["aptGetUpdate"],Class["apt"]]
  }

  exec { "npm-update" :
      cwd => "/vagrant",
      command => "npm -g update",
      onlyif => ["test -d /vagrant/node_modules"],
      path => ["/bin", "/usr/bin"],
      require => Package['nodejs']
  }
}

class { '::mysql::server':
  root_password    => 'devpass',
  override_options => { 'mysqld' => { 'max_connections' => '1024' } }
}

include apt_update
include othertools
include node-js
include '::mysql::server'
