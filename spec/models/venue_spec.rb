require 'spec_helper'

describe Venue do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = {
      :name => 'Haunt',
      :address => '1001 Main',
      :address2 => 'nothing',
      :city => 'Detroit', 
      :state => 'MI',
      :zipcode => '48207',
      :phone_number => '313-3130',
      :user_id => @user.id
    }
  end

  it "should create a new instance given valid attributes" do
    Venue.create(@attr)
  end

  it "should require a name" do
    something_missing = Venue.new(@attr.merge(:name => nil))
    something_missing.should_not be_valid
  end

  it "should require an address" do
    something_missing = Venue.new(@attr.merge(:address => nil))
    something_missing.should_not be_valid
  end

  it "should require a city" do
    something_missing = Venue.new(@attr.merge(:city => nil))
    something_missing.should_not be_valid
  end

  it "should require a state" do
    something_missing = Venue.new(@attr.merge(:state => nil))
    something_missing.should_not be_valid
  end

  it "should require a zip" do
    something_missing = Venue.new(@attr.merge(:zipcode => nil))
    something_missing.should_not be_valid
  end

  it "should require a phone number" do
    something_missing = Venue.new(@attr.merge(:phone_number => nil))
    something_missing.should_not be_valid
  end

  it "should require a user" do
    something_missing = Venue.new(@attr.merge(:user_id => nil))
    something_missing.should_not be_valid
  end

end
