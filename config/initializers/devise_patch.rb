# https://github.com/heartcombo/devise/issues/5644
Devise.setup do |config|
  if Rails.application.respond_to?(:credentials) && Rails.application.credentials.secret_key_base.present?
    puts "Using credentials secret_key_base"
    config.secret_key = Rails.application.credentials.secret_key_base
  elsif ENV["SECRET_KEY_BASE"].present?
    puts "Using ENV SECRET_KEY_BASE"
    config.secret_key = ENV["SECRET_KEY_BASE"]
  else
    raise "Devise secret_key is not set. Make sure SECRET_KEY_BASE is configured."
  end
end
