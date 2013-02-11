class Product < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :issue, :price, :user, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  #validates :image_url, allow_blank: true, format: {
  #with: %r{\.(gif|jpg|png)$}i,
  # message: 'must be a URL for GIF, JPG or PNG image.' }
  validates_attachment :picture, :presence => true,
                       :size => {:in => 0..500.kilobytes}
  has_attached_file :picture,
                    :styles => {
                        :thumb => "100x130",
                        :small => "150x205",
                        :medium => "190x245",
                        :large => "300x390"}

  #:styles => { :medium => "225x300>", :thumb => "100x100>" }

  attr_accessible :picture, :issue, :price, :title, :user_id , :product_id

  def self.search(search_query)
    if search_query
      find(:all, :conditions => ['title || issue LIKE ?', "%#{ search_query}%"])
    else
      find(:all)
    end
  end

  private

  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
end
