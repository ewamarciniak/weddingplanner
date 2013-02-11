class FavouriteListing < ActiveRecord::Base
  attr_accessible :listing_id, :user_id

  belongs_to :user
  belongs_to :listing
  validates :listing_id, :uniqueness => {:scope => :user_id}

end
