module CompanyAdmin
  class EventsController < BaseController
    before_filter :verify_event_admin

    def new
      @user = current_user
      @venues = Venue.where(:user_id => @user.id)
      @event = Event.new
    end

    def edit
      @user = current_user
      @venues = Venue.where(:user_id => @user.id)
      @event = Event.find(params[:id])
    end

    def index
      @user = current_user
      @venues = Venue.where(:user_id => @user.id).map {|venue| venue.id}
      @events = Event.where(:venue_id => @venues)
    end

    def create
      @event = Event.new(params[:event])
      
      if @event.save
        flash[:notice] = 'Event has been saved'
        redirect_to company_admin_events_url
      else
        render :new
      end
    end

    def update
      @event = Event.find(params[:id])

      if @event.update_attributes(params[:event])
        flash[:notice] = 'Event has been updated'
        redirect_to company_admin_events_url
      else
        render :edit
      end
    end

    def destroy
      @event = Event.find(params[:id])
      @event.destroy
      flash[:notice] = "Event has been deleted"
      redirect_to company_admin_events_url
    end

    private

    def verify_event_admin
      if (current_user.has_role? :company_admin, Event) == false
        flash[:alert] = "You do not have permission to access this page"
        redirect_to root_url
      end
    end

  end

end
