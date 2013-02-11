class Listing < ActiveRecord::Base
  attr_accessible :business_name, :description, :user_id, :picture, :category, :phone_number, :fax_number, :email, :website, :address
  belongs_to :user
  has_many :listing_votes
  has_many :favourite_listings

  validates :business_name, :description, :category,:address, presence: true
  validates_attachment :picture,
                     :presence => true,
                    #:content_type => { :content_type => "image/jpg" },
                     :size => {:in => 0..900.kilobytes}
                           #:content_type => 'image/jpeg'
  #:content_type => ['image/jpeg', 'jpg/jpg', 'image/png', 'image/gif', 'image/tif', 'image/bmp' 'application/pdf']

  has_attached_file :picture,
                    :styles => {
                        :thumb => "100x130",
                        :small => "150x205",
                        :medium => "245x195",
                        :large => "300x390"},
                        :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                        :url => "/system/:attachment/:id/:style/:filename"

  validate :check_content_type
  acts_as_gmappable :process_geocoding => true

  def gmaps4rails_address
    "#{self.address}"
  end

  def check_content_type
    if !['image/jpeg', 'image/gif','image/png', 'image/jpg', 'image/tif', 'image/bmp'].include?(self.picture_content_type)
      errors[:base] << "Image '#{self.picture_file_name}' is not a valid image type"
      return false
    end
  end
  def self.by_votes
    select('listings.*, coalesce(value, 0) as votes').
        joins('left join listing_votes on listing_id=listings.id').
        order('votes desc')
  end

  def votes
    read_attribute(:votes) || listing_votes.sum(:value)
  end

  def sum_of_votes
    ListingVote.joins(:listing).where(listings: {id: self.id}).sum('value')
  end

=begin
  def self.search(search_query)
    if search_query
      find(:all, :conditions => ['business_name LIKE ?', "%#{ search_query}%"])
    else
      find(:all)
    end
  end
=end


end

