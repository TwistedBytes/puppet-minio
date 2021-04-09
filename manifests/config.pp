# Class: minio::config
# ===========================
#
# Applies configuration for `::minio` class to system.
#
# Parameters
# ----------
#
# * `configuration`
# INI style settings for configuring Minio.
#
# * `owner`
# The user owning minio and its' files. Default: 'minio'
#
# * `group`
# The group owning minio and its' files. Default: 'minio'
#
# * `configuration_directory`
# Directory holding Minio configuration file. Default: '/etc/minio'
#
# * `installation_directory`
# Target directory to hold the minio installation. Default: '/opt/minio'
#
# * `storage_root`
# Directory where minio will keep all data. Default: '/var/minio'
#
# * `log_directory`
# Log directory for minio. Default: '/var/log/minio'
#
# Authors
# -------
#
# Daniel S. Reichenbach <daniel@kogitoapp.com>
#
# Copyright
# ---------
#
# Copyright 2017 Daniel S. Reichenbach <https://kogitoapp.com>
#
class minio::config (
  String $listen_ip            = $minio::listen_ip,
  Integer $listen_port         = $minio::listen_port,

  String $root_user            = $minio::root_user,
  String $root_password        = $minio::root_password,

  Boolean $root_config_enable  = false,
  Boolean $root_config_replace = false,
) {

  file { "/etc/default/minio":
    content => template('minio/systemd_env.erb'),
    mode    => '0600',
  }

  if $root_config_enable {
    file { "/root/.mc":
      ensure => 'directory',
      mode   => "0700",
    }

    file { "/root/.mc/config.json":
      content => template('minio/config.json.erb'),
      mode    => '0600',
      replace => $root_config_replace,
    }
  }

}
