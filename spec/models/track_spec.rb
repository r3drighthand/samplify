require 'rails_helper'

describe Track do
  before(:each) do
    @track = build(:track)
  end

  it "should create a new instance of a track given valid attributes" do
    expect(@track).to be_valid
  end

  it "is invalid without a sampler"
  it "is invalid without a name"
  it "belongs to a sampler"
end