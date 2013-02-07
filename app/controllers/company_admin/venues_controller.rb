module CompanyAdmin
  class VenuesController < BaseController
    before_filter :verify_venue_admin

    def new
      @venue = Venue.new
    end

    def edit
      @venue = Venue.find(params[:id])
    end

    def index
      @user = current_user
      @venues = Venue.where(:user_id => @user.id)
    end

    def create
      @venue = Venue.new(params[:venue])
      
      if @venue.save
        flash[:notice] = 'Venue has been saved'
        redirect_to company_admin_venues_url
      else
        render :new
      end
    end

    def update
      @venue = Venue.find(params[:id])

      if @venue.update_attributes(params[:venue])
        flash[:notice] = 'Venue has been updated'
        redirect_to company_admin_venues_url
      else
        render :edit
      end
    end

    def destroy
      @venue = Venue.find(params[:id])
      @venue.destroy
      flash[:notice] = "Venue has been deleted"
      redirect_to company_admin_venues_url
    end

    private

    def verify_venue_admin
      if (current_user.has_role? :company_admin, Venue) == false
        flash[:alert] = "You do not have permission to access this page"
        redirect_to root_url
      end
    end

  end

end
