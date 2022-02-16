require 'rails_helper'

RSpec.describe Order, :type => :model do
  subject { 
    described_class.new(
      username: "cheikh",
      name: "cheikh",
      email: "mail@mail.com",
      adress: "1 rue quelque chose",
      total_price: 100.00,
      customer_stripe_id: "aaaaaaaaaaa",
      user_id: 11,
      cart_id: 11
    )
   }

   it "is valid with validations" do 
    expect(subject).to be_valid
   end

   it { should belong_to(:user).optional } 
   it { should belong_to(:cart).optional } 
end