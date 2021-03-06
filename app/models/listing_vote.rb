class ListingVote < ActiveRecord::Base
  attr_accessible :value, :listing, :listing_id
  belongs_to :listing
  belongs_to :user

  validates_uniqueness_of :listing_id, scope: :user_id
  validates_inclusion_of :value, in: [1, -1]
  validate :ensure_not_author

  def ensure_not_author
    errors.add :user_id, "is the author of the listing" if listing.user_id == user_id
  end


end
