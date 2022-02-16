class Order < ApplicationRecord
  validates_presence_of :username, on: :create, message: "can't be blank"
  validates_presence_of :name, on: :create, message: "can't be blank"
  validates_presence_of :email, on: :create, message: "can't be blank"
  validates_presence_of :adress, on: :create, message: "can't be blank"
  validates_presence_of :total_price, on: :create, message: "can't be blank"
  validates_presence_of :customer_stripe_id, on: :create, message: "can't be blank"
  
  belongs_to :user, optional: true
  belongs_to :cart, optional: true

  has_many :line_items
end
