class VenuesController < ApplicationController
  layout 'signed_in'
  before_filter :authenticate_user!

  def new
    @venue = Venue.new
  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def index
    @user = current_user
    @venues = Venue.all
  end

  def show
    @venue = Venue.find(params[:id])
  end

  def create
    @venue = Venue.new(params[:venue])
    
    if @venue.save
      flash[:notice] = 'Venue has been saved'
      redirect_to venues_url
    else
      render :new
    end
  end

  def update
    @venue = Venue.find(params[:id])

    if @venue.update_attributes(params[:venue])
      flash[:notice] = 'Venue has been updated'
      redirect_to venues_url
    else
      render :edit
    end
  end

  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy
  end

end
