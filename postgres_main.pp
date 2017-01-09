

class  project::postgres_main(
  $pg_version = '9.6',
  $master_pass,
 
) {



  #create directory for postgres data directory  
   file { "/local/pgsql":
    ensure => directory,
     owner  => 'postgres',
    group  => 'postgres',
    mode   => '0750',
  }
  
   #create directory for postgres data directory  
   file { "/local/pgsql/9.6":
    ensure => directory,
     owner  => 'postgres',
    group  => 'postgres',
    mode   => '0750',
  }
   
       
      
  
# ----------------------------------------------------------------------------
  # Install postgres server.

  $pg_service = "postgresql-${pg_version}"

  class { 'postgresql::globals':
    version             => $pg_version,
    manage_package_repo => true,
    datadir => '/local/pgsql/9.6/data',
  }
  ->
  class { 'postgresql::server':
    service_restart_on_change => true,
    listen_addresses           => '*',
  }

 

# ---------------------------------------------------------------------------- 
# postgres config parameters (postgresql.conf)
 
  postgresql::server::config_entry { 'max_connections':
    value => '750',
  }
  postgresql::server::config_entry { 'log_min_error_statement':
    value => 'error',
  }
  postgresql::server::config_entry { 'autovacuum':
    value => 'on',
  }
 postgresql::server::config_entry { 'shared_buffers':
    value => '256MB',
  }
   postgresql::server::config_entry { 'work_mem':
    value => '32MB',
  }
   postgresql::server::config_entry { 'maintenance_work_mem':
    value => '128MB',
  }
   postgresql::server::config_entry { 'temp_file_limit':
    value => '-1',
  }
   
    postgresql::server::config_entry { 'log_min_duration_statement':
    value => '0',
  }
   postgresql::server::config_entry { 'log_timezone':
    value => 'UTC',
  }
     postgresql::server::config_entry { 'log_line_prefix':
    value => '%t [%p]: [%l-1] user=%u,db=%d,app=%a,client=%h',
  }
     postgresql::server::config_entry { 'log_checkpoints':
    value => 'on',
  }
     postgresql::server::config_entry { 'log_connections':
    value => 'on',
  }
  
     postgresql::server::config_entry { 'log_disconnections':
    value => 'on',
  }
     postgresql::server::config_entry { 'log_lock_waits':
    value => 'on',
  }
     postgresql::server::config_entry { 'log_temp_files':
    value => '0',
  }
     postgresql::server::config_entry { 'log_autovacuum_min_duration':
    value => '0',
  }
     postgresql::server::config_entry { 'lc_messages':
    value => 'en_AU.UTF-8',
  }
     postgresql::server::config_entry { 'lc_monetary':
    value => 'en_AU.UTF-8',
  }
    postgresql::server::config_entry { 'lc_numeric':
    value => 'en_AU.UTF-8',
  }
    postgresql::server::config_entry { 'lc_time':
    value => 'en_AU.UTF-8',
  }
        
      postgresql::server::config_entry { 'wal_level':
    value => 'hot_standby',
  }
    postgresql::server::config_entry { 'max_wal_senders':
    value => '5',
  }
    postgresql::server::config_entry { 'wal_keep_segments':
    value => '32',
  }
    postgresql::server::config_entry { 'hot_standby':
    value => 'on',
  }
  
       
  
# Create test db and admin user.
 
        
  
# Create Extensions

  class { 'postgresql::server::contrib':}
  class { 'postgresql::server::postgis': }
  class { 'postgresql::lib::devel': }
  
     
# ----------------------------------------------------------------------------
# Add any additional settings *above* this comment block.
# ----------------------------------------------------------------------------


}
