class AdminController < ApplicationController
  def index
    @tab ='admindashboard'
    @total_users = User.count
    @total_private = User.count - Vendor.count - User.where(:admin => true).count
    @total_vendors = Vendor.count
    @total_products = Product.count
    @total_admins = User.where(:admin => true).count
    @total_listings = Listing.count
    @total_orders = Order.count
  end
end
