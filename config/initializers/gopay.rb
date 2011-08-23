GoPay.configure do |config|
  config.environment = :test
end

GoPay.configure_from_yaml(File.join(Rails.root, "config", "gopay.yml"))