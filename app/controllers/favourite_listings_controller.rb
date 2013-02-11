class FavouriteListingsController < ApplicationController
  # GET /favourite_listings
  # GET /favourite_listings.json
  before_filter :authorize

  def index
    @tab="favourites"
    @favourite_listings = current_user.favourite_listings

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @favourite_listings }
    end
  end

  # GET /favourite_listings/1
  # GET /favourite_listings/1.json
  def show
    @favourite_listing = FavouriteListing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @favourite_listing }
    end
  end

  # GET /favourite_listings/new
  # GET /favourite_listings/new.json
  def new
    @favourite_listing = FavouriteListing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @favourite_listing }
    end
  end

  # GET /favourite_listings/1/edit
  def edit
    @favourite_listing = FavouriteListing.find(params[:id])
  end

  # POST /favourite_listings
  # POST /favourite_listings.json
  def create
   # @favourite_listing = FavouriteListing.new(params[:favourite_listing])
    #@favourite_listing.user = current_user
    #@favourite_listing.listing = Listing.find(params[:listing_id])

    @favourite_listing= current_user.add_to_favourites(params[:listing_id])

      if @favourite_listing.save
        redirect_to favourite_listings_url, :notice => "Current listening was added to your favourites"
      else
        redirect_to favourite_listings_url, :alert => "Listing has already been added"
      end
  end

  # PUT /favourite_listings/1
  # PUT /favourite_listings/1.json
  def update
    @favourite_listing = FavouriteListing.find(params[:id])

    respond_to do |format|
      if @favourite_listing.update_attributes(params[:favourite_listing])
        format.html { redirect_to @favourite_listing, notice: 'Favourite listing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @favourite_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favourite_listings/1
  # DELETE /favourite_listings/1.json
  def destroy
    @favourite_listing = FavouriteListing.find(params[:id])
    @favourite_listing.destroy

    respond_to do |format|
      format.html { redirect_to favourite_listings_url }
      format.json { head :no_content }
    end
  end
end
