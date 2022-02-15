require "rails_helper"

RSpec.describe Item, :type => :model do
  subject {
    described_class.new(title: "foo",
                        description: "Lorem ipsum",
                        price: 10.00)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without description" do
    subject.description = nil
    expect(subject).not_to be_valid
  end

  it "is not valid without price" do
    subject.price = nil
    expect(subject).not_to be_valid
  end
end
