require 'spec_helper'

describe CompanyAdmin::VenuesController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @venue = {
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

  it "should redirect to new session if no logged in user user" do
    get :index
    response.should redirect_to new_user_session_url
  end

  it "should redirect if user doesn't have company_admin venue role" do
    sign_in(@user)
    get :index
    response.should redirect_to root_url
  end

  describe "GET index" do
    before(:each) do
      @user.add_role :company_admin, Venue
      sign_in(@user)
      @venue = Venue.create!(@venue)
    end

    it "should assign an array of venues" do
      get :index
      assigns(:venues).should == [@venue]
    end

    it "should render the index template" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET new" do
    before(:each) do
      @user.add_role :company_admin, Venue
      sign_in(@user)
    end

    it "should assign a venue variable" do
      get :new
      assigns(:venue).should be_a_new(Venue)
    end

    it "should render the new template" do
      get :new
      response.should render_template :new
    end
  end
  
  describe "GET edit" do
    before(:each) do
      @user.add_role :company_admin, Venue
      sign_in(@user)
      @venue = Venue.create!(@venue)
    end

    it "should find and assign a venue variable" do
      get :edit, :id => @venue.id
      assigns(:venue).should == @venue
    end

    it "should render the edit template" do
      get :edit, :id => @venue.id
      response.should render_template :edit
    end
  end

  describe "POST create" do
    before(:each) do
      @user.add_role :company_admin, Venue
      sign_in(@user)
    end

    context "with valid attributes" do
      it "should save a venue to the database" do
        expect{
          post :create, :venue => @venue
        }.to change(Venue, :count).by(1)
      end
      
      it "should redirect to index view" do
        post :create, :venue => @venue
        response.should redirect_to company_admin_venues_url
      end
    end

    context "with invalid attributes" do
      it "should not save a venue to the database" do
        expect{
          post :create, :venue => {}
        }.to_not change(Venue, :count)
      end
      
      it "should render new with errors" do
        post :create, :venue => {}
        response.should render_template :new
        assigns(:venue).errors.should_not be_empty
      end
    end

  end

  describe "PUT edit" do
    before(:each) do
      @user.add_role :company_admin, Venue
      sign_in(@user)
      @venue = Venue.create!(@venue)
    end

    it "should locate venue" do
      put :update, :id => @venue.id, :venue => {:name => 'foobar'}
      assigns(:venue).should == @venue
    end

    context "with valid attributes" do
      it "should update venue with new data" do
        put :update, :id => @venue.id, :venue => {:name => 'foobar'}
        @venue.name.should == 'Haunt'
        @venue.reload
        @venue.name.should == 'foobar'
      end

      it "should redirect to index url" do
        put :update, :id => @venue.id, :venue => {:name => 'foobar'}
        response.should redirect_to company_admin_venues_url
      end
    end

    context "with invalid attributes" do
      it "should not update the venue" do
        put :update, :id => @venue.id, :venue => {:name => nil}
        @venue.reload
        @venue.name.should_not == nil
      end

      it "should render the edit template with errors" do
        put :update, :id => @venue.id, :venue => {:name => nil}
        response.should render_template :edit
        assigns(:venue).errors.should_not be_empty
      end
    end


  end


end
