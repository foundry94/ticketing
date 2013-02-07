class Venue < ActiveRecord::Base
  attr_accessible :address, :address2, :city, :name, :phone_number, :state, :user_id, :zipcode
end
