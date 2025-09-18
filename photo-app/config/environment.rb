# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :address => 'udemy-rails-mail',
  :port => 1025,
  :authentication => :plain,
  :user_name => ENV['SENDGRID_USERNAME'] || 'smtp-user',
  :password => ENV['SENDGRID_PASSWORD'] || 'smtp-pass',
  :domain => 'localhost.localdomain',
  :enable_starttls_auto => true
}
