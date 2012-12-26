# config/initializers/load_config.rb
def app_config
  @app_config ||= YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]
end