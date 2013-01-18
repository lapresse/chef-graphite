# Activate/Deactive components
default['graphite']['components']['web'] = false
default['graphite']['components']['whisper'] = false
default['graphite']['components']['carbon'] = false

# Carbon
default['carbon']['storage_dir'] = '/var/lib/carbon/'
default['carbon']['local_data_dir'] = '/var/lib/carbon/whisper/'
default['carbon']['whitelists_dir'] = '/var/lib/carbon/lists/'
default['carbon']['conf_dir'] = '/etc/carbon/'
default['carbon']['log_dir'] = '/var/log/carbon/'
default['carbon']['pid_dir'] = '/var/run/'
default['carbon']['user'] = 'carbon'

# Graphite
default['graphite']['user'] = 'apache'
default['graphite']['group'] = 'apache'
default['graphite']['doc_root'] = '/var/www/html'

# Ceres
default['ceres']['installed'] = false
