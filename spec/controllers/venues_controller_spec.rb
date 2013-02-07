require 'spec_helper'

describe VenuesController do
  before(:each) do
    @venue = FactoryGirl.create(:venue)
  end

  describe "GET index" do

    it "should assign an array of venues" do
      get :index
      assigns(:venues).should == [@venue]
    end

    it "should render the index template" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET show" do

    it "should assign a venue variable" do
      get :show, :id => @venue.id
      assigns(:venue).should == @venue
    end

    it "should render the show template" do
      get :show, :id => @venue.id
      response.should render_template :show
    end
  end

end
