ActionMailer::Base.smtp_settings = {
  :user_name => Rails.application.credentials.sendgrid[:sendgrid_login],
  :password => Rails.application.credentials.sendgrid[:sendgrid_pwd],
  :domain => 'https://marvel-comics-shop.herokuapp.com/',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}