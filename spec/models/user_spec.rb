require 'rails_helper'

describe User do
  before(:each) do
    @user = build(:user)
  end

  it "should create a new instance of a user given valid attributes" do
    expect(@user).to be_valid
  end
end