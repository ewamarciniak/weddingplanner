class Guest < ActiveRecord::Base
  belongs_to :user
  attr_accessible :first_name, :invitation_sent, :last_name, :relationship, :rsvp, :spec_food_req, :title
  validates :first_name, :last_name, :relationship, :title, :spec_food_req, presence: true

end
