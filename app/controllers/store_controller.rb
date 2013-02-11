class StoreController < ApplicationController
  skip_before_filter :authorize

  def index
    @tab="store"
    @products = Product.search(params[:search_query])
    @cart = current_cart

    respond_to do |format|
      format.html
      format.json { render json: @product }
    end
  end

end
