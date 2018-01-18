default['rsyslog']['port'] = '5514;ls_json'
default['rsyslog']['protocol'] = 'tcp'
default['rsyslog']['templates'] = [ "ls_json,\"{%timestamp:::date-rfc3339,jsonf:timestamp%,%source:::jsonf:@source_host%,\\\"@source\\\":\\\"syslog://%fromhost-ip:::json%\\\",\\\"@message\\\":\\\"%msg:::json%\\\",\\\"facility\\\":\\\"%syslogfacility-text:::json%\\\",\\\"severity\\\":\\\"%syslogseverity-text:::json%\\\",\\\"program\\\":\\\"%app-name:::json%\\\",\\\"procid\\\":\\\"%procid:::json%\\\"}\"" ]   
