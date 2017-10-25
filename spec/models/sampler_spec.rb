require 'rails_helper'

describe Sampler do
  before(:each) do
    @sampler = build(:sampler)
  end

  it "should create a new instance of a sampler given valid attributes" do
    expect(@sampler).to be_valid
  end

  it "is invalid without a user"
end