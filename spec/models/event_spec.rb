require 'spec_helper'

describe Event do
  before(:each) do
    @venue = FactoryGirl.create(:venue)
    @attr = {
      :name => 'Event!',
      :price => 20,
      :venue_id => @venue.id
    }
  end

  it "should create a new instance with valid attributes" do
    event = Event.create!(@attr)
  end

  it "should require a name" do
    missing_something = Event.new(@attr.merge(:name => nil))
    missing_something.should_not be_valid
  end

  it "should require a price" do
    missing_something = Event.new(@attr.merge(:price => nil))
    missing_something.should_not be_valid
  end

  it "should require a venue" do
    missing_something = Event.new(@attr.merge(:venue_id => nil))
    missing_something.should_not be_valid
  end

  it "should belong to a venue" do
    event = Event.create!(@attr)
    event.venue.should == @venue
  end
end
