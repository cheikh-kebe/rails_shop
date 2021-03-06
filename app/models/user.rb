class User < ApplicationRecord
  after_create :create_stripe_customer
  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :cart, optional: true
  has_many :orders
  has_one_attached :avatar

  def create_stripe_customer
    customer = Stripe::Customer.create({
      email: self.email,
    })
    self.customer_stripe_id = customer.id
    self.save
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
