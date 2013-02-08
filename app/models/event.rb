class Event < ActiveRecord::Base
  belongs_to :venue
  attr_accessible :name, :price, :venue_id
  validates_presence_of :name, :price, :venue_id
end
