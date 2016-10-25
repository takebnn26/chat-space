require 'rails_helper'

describe Message do

  it "is valid a name" do
    message = build(:message)
    expect(message).to be_valid
  end

  it "is invalid without a name" do
    message = build(:message, content: "")
    message.valid?
    expect(message.errors[:content]).to include("can't be blank")
  end

end
