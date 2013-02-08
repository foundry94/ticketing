require 'spec_helper'

describe CompanyAdmin::EventsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @venue_attr = {
      :name => 'Haunt',
      :address => '1001 Main',
      :address2 => 'nothing',
      :city => 'Detroit', 
      :state => 'MI',
      :zipcode => '48207',
      :phone_number => '313-3130',
      :user_id => @user.id
    }
    @venue = Venue.create!(@venue_attr)
    @event = {
      :name => 'Halloween Scare',
      :price => 35,
      :venue_id => @venue.id
    }
  end

  it "should redirect to new session if no logged in user user" do
    get :index
    response.should redirect_to new_user_session_url
  end

  it "should redirect if user doesn't have company_admin Event role" do
    sign_in(@user)
    get :index
    response.should redirect_to root_url
  end

  describe "GET index" do
    before(:each) do
      @user.add_role :company_admin, Event
      sign_in(@user)
      @event = Event.create!(@event)
    end

    it "should assign a user" do
      get :index
      assigns(:user).should == @user
    end

    it "should assign an array of venue ids" do
      get :index
      assigns(:venues).should == [@venue.id]
    end

    it "should assign an array of events at user's venues" do
      get :index
      assigns(:events).should == [@event]
    end

    it "should render the index template" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET new" do
    before(:each) do
      @user.add_role :company_admin, Event
      sign_in(@user)
    end

    it "should assign a user" do
      get :new
      assigns(:user).should == @user
    end

    it "should assign an array of venue ids" do
      get :new
      assigns(:venues).should == [@venue]
    end

    it "should assign a event variable" do
      get :new
      assigns(:event).should be_a_new(Event)
    end

    it "should render the new template" do
      get :new
      response.should render_template :new
    end
  end
  
  describe "GET edit" do
    before(:each) do
      @user.add_role :company_admin, Event
      sign_in(@user)
      @event = Event.create!(@event)
    end

    it "should assign a user" do
      get :edit, :id => @event
      assigns(:user).should == @user
    end

    it "should assign an array of venues" do
      get :edit, :id => @event
      assigns(:venues).should == [@venue]
    end

    it "should find and assign an event variable" do
      get :edit, :id => @event
      assigns(:event).should == @event
    end

    it "should render the edit template" do
      get :edit, :id => @event
      response.should render_template :edit
    end
  end

  describe "POST create" do
    before(:each) do
      @user.add_role :company_admin, Event 
      sign_in(@user)
    end

    context "with valid attributes" do
      it "should save an event to the database" do
        expect{
          post :create, :event => @event
        }.to change(Event, :count).by(1)
      end
      
      it "should redirect to index view" do
        post :create, :event => @event
        response.should redirect_to company_admin_events_url
      end
    end

    context "with invalid attributes" do
      it "should not save a event to the database" do
        expect{
          post :create, :event => {}
        }.to_not change(Event, :count)
      end
      
      it "should render new with errors" do
        post :create, :event => {}
        response.should render_template :new
        assigns(:event).errors.should_not be_empty
      end
    end

  end

  describe "PUT update" do
    before(:each) do
      @user.add_role :company_admin, Event
      sign_in(@user)
      @event = Event.create!(@event)
    end

    it "should locate event" do
      put :update, :id => @event.id, :event => {:name => 'foobar'}
      assigns(:event).should == @event
    end

    context "with valid attributes" do
      it "should update event with new data" do
        put :update, :id => @event.id, :event => {:name => 'foobar'}
        @event.name.should == 'Halloween Scare'
        @event.reload
        @event.name.should == 'foobar'
      end

      it "should redirect to index url" do
        put :update, :id => @event.id, :event => {:name => 'foobar'}
        response.should redirect_to company_admin_events_url
      end
    end

    context "with invalid attributes" do
      it "should not update the event" do
        put :update, :id => @event.id, :event => {:name => nil}
        @event.reload
        @event.name.should_not == nil
      end

      it "should render the edit template with errors" do
        put :update, :id => @event.id, :event => {:name => nil}
        response.should render_template :edit
        assigns(:event).errors.should_not be_empty
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) do 
      @user.add_role :company_admin, Event
      sign_in(@user)
      @event = Event.create!(@event)
    end

    it "should delete the event from the database" do
      expect{
        delete :destroy, :id => @event.id
      }.to change(Event, :count).by(-1)
    end

    it "should redirect to index view" do
      delete :destroy, :id => @event.id
      response.should redirect_to company_admin_events_url
    end
  end

  describe "verify_event_admin" do
    before(:each) do
      sign_in(@user)
    end

    context "a user without event admin priviledges" do
      it "should not allow user access and should redirect to root" do
        get :index
        response.should redirect_to root_url
      end
    end

    context "a user with event access" do
      it "should allo user to access pages" do
        @user.add_role :company_admin, Event
        get :index
        response.should be_success
      end
    end
  end


end
