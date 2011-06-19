config_file =  File.expand_path('../../application.yml', __FILE__)
APPLICATION_CONFIG=YAML.load_file(config_file)[Rails.env]['application']
CONSTANTS=YAML.load_file(config_file)[Rails.env]['constants']