class Event < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :tasks
	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
end
