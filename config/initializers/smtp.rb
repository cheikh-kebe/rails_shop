ActionMailer::Base.smtp_settings = {
  :user_name => Rails.application.credentials.,
  :password => ENV['SENDGRID_PWD'],
  :domain => 'https://marvel-comics-shop.herokuapp.com/',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}