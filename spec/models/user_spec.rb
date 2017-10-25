require 'rails_helper'

describe User do
  before(:each) do
    @user = build(:user)
  end

  it "should create a new instance of a user given valid attributes" do
    expect(@user).to be_valid
  end

  it "is invalid without a display name" do
    expect(build(:user, display_name: nil)).not_to be_valid
  end

  it "is invalid without an email address" do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it "is invalid without a spotify account" do
    expect(build(:user, spotify_id: nil)).not_to be_valid
  end
end