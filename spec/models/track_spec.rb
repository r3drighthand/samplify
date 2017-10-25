require 'rails_helper'

describe Track do
  before(:each) do
    @track = build(:track)
  end

  it "should create a new instance of a track given valid attributes" do
    expect(@track).to be_valid
  end

  it "is invalid without a sampler" do
    expect(build(:track, sampler_id: nil)).not_to be_valid
  end

  it "is invalid without a name" do
    expect(build(:track, name: nil)).not_to be_valid
  end

  it "belongs to a sampler" do
    expect(@track.sampler).to be_a_kind_of(Sampler)
  end
end