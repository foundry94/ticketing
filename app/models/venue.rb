class Venue < ActiveRecord::Base
  attr_accessible :address, :address2, :city, :name, :phone_number, :state, :user_id, :zipcode
  validates_presence_of :name, :address, :city, :state, :zipcode, :phone_number, :user_id
end
