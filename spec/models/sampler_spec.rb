require 'rails_helper'

describe Sampler do
  before(:each) do
    @sampler = build(:sampler)
  end

  it "should create a new instance of a sampler given valid attributes" do
    expect(@sampler).to be_valid
  end

  it "is invalid without a user" do
    expect(build(:sampler, user_id: nil)).not_to be_valid
  end

  it "belongs to one user" do
    expect(@sampler.user).to be_a_kind_of(User)
  end
end