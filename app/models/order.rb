class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :pay_type
  validates :name, :address, :email, :pay_type, presence: true
  has_many :line_items, dependent: :destroy
  belongs_to :user,  :dependent => :destroy
  validates :email,
            :length => {:minimum => 5, :maximum => 50},
            :format => {:with =>
                            /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i}

  validates :email, :address, :name, :pay_type, presence: true

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def total_price
    total = 0
    line_items.each do |item|
      total +=  item.total_price
    end
    total
  end
end
