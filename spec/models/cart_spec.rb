require 'rails_helper'

RSpec.describe Cart, :type => :model do 
  subject { 
    described_class.new()
   } 

   it { should belong_to(:user).optional } 
   it { should have_many(:line_items) } 
   it { should have_many(:items).through(:line_items) } 

  end