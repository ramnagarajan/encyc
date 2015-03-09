# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

 ActionMailer::Base.delivery_method = :smtp


# smtp_config = CustomMailer.SMTP_SETTINGS

# ActionMailer::Base.username = smtp_config.username
# ActionMailer::Base.password = smtp_config.password
# ActionMailer::Base.server = ""
# ActionMailer::Base.port = "598"
# ActionMailer::Base.authentication = 'plain'
# ActionMailer::Base.enable_starttls_auto = true

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'demonstrate.nfnlabs.in',
  :user_name            => 'recovery@nfnlabs.in',
  :password             => 'Remember002',
  :authentication       => 'plain',
  :enable_starttls_auto => true  }
  

