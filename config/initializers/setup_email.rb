ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :address              => Rails.application.secrets.address,
  :port                 => Rails.application.secrets.port,
  :domain               => Rails.application.secrets.domain,
  :user_name            => Rails.application.secrets.user_name,
  :password             => Rails.application.secrets.password,
  :authentication       => "plain",
  :enable_starttls_auto => true
}
if Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.default_url_options = { :host => '178.62.40.115' }
else
  ActionMailer::Base.delivery_method = :letter_opener
  ActionMailer::Base.default_url_options = { :host => 'localhost:3000' }
end
