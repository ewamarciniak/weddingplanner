class ListingsController < ApplicationController
  skip_before_filter :authorize, :only => [:show]
  before_filter :is_vendor?, :except => [:show, :vote]
  before_filter :is_admin?, :only => [:index]

  # GET /listings
  # GET /listings.json
  def index
    @tab="listings"
    @listings = Listing.paginate page: params[:page], order: 'created_at desc', per_page: 10
    @json = @listings.to_gmaps4rails

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @listings }
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show

      @listing = Listing.find_by_id(params[:id])
      @json = @listing.to_gmaps4rails

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @listing }
    end
  end

  # GET /listings/new
  # GET /listings/new.json
  def new
    @listing = Listing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @listing }
    end
  end

  # GET /listings/1/edit
  def edit
    @listing = Listing.find(params[:id])
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = current_user.listings.new(params[:listing])

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'The listing has been created succesfully' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /listings/1
  # PUT /listings/1.json
  def update
    @listing = Listing.find(params[:id])

    respond_to do |format|
      if @listing.update_attributes(params[:listing])
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy

    respond_to do |format|
      if current_user.type=="Vendor"
      format.html { redirect_to root_url }
      else
        format.html { redirect_to listings_url }
        end
      format.json { head :no_content }
    end
  end


  def vote
    vote = current_user.listing_votes.new(value: params[:value], listing_id: params[:id])
    if vote.save
      redirect_to :back, notice: "Thank you for voting."
    else
      redirect_to :back, alert: "Unable to vote, perhaps you already did."
    end
  end
end
