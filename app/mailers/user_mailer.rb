class UserMailer < ApplicationMailer
  default from: 'crazyrabitt.01@gmail.com'

  def welcome_email(user)
    @user = user
    @website = "Marvel Comics Shop"
    @url  = 'https://marvel-comics-shop.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Bienvenue sur Marvel Comics Shop')
  end
end
