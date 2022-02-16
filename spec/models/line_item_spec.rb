require 'rails_helper'

RSpec.describe LineItem, :type => :model do
  subject { 
    described_class.new()
   }
   
   it { should belong_to(:item) }
   it { should belong_to(:cart) } 
   it { should belong_to(:order).optional } 
end
