#reference http://railscasts.com/episodes/274-remember-me-reset-password accessed 20/11/2012
#reference http://apidock.com/rails/ActiveModel/Validations/ClassMethods/validates accessed 20.11.2012
class User < ActiveRecord::Base
  after_destroy :ensure_an_admin_remains
  has_many :products
  has_many :listings
  has_many :guests
  has_many :orders
  has_many :todos
  has_many :listing_votes
  has_many :favourite_listings
  has_many :inspirations
  has_secure_password

  validates :login_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :login_name,
            :length => {:minimum => 1, :maximum => 254}
  validates :password,
            :length => {:minimum => 6, :maximum => 15, :on => :create}
  validates :email,
            :length => {:minimum => 5, :maximum => 50},
            :format => {:with =>
                            /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i}
  before_create { generate_token(:auth_token) }
  attr_accessible :admin, :billing_address_city, :billing_address_county, :billing_address_line1, :billing_address_line2, :billing_address_postcode, :company_name, :email, :first_name, :last_name, :login_name, :password, :password_confirmation, :shipping_address_city, :shipping_address_county, :shipping_address_line1, :shipping_address_line2, :shipping_address_postcode, :wedding_date

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def total_votes
    ListingVote.joins(:listing).where(listings: {user_id: self.id}).sum('value')
  end

  def can_vote_for?(listing)
    listing_votes.build(value: 1, listing: listing).valid?
  end

  def add_to_favourites(listing_id)
    favourite_listings.build(listing_id: listing_id)
  end

  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
end

