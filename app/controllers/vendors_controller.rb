class VendorsController < ApplicationController
  # GET /users
  # GET /users.json
  before_filter :is_vendor?, :except => [:new, :create]
  before_filter :is_admin?, :only => [:index]
  skip_filter :authorize, :only => [:new, :create]

  def index
    @tab="vendors"
    @vendors = Vendor.order(:login_name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vendors }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @vendor = Vendor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vendor }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @vendor = Vendor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vendor }
    end
  end


  # GET /users/1/edit
  def edit
    @vendor = Vendor.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @vendor = Vendor.new(params[:vendor])

    respond_to do |format|
      if @vendor.save
        format.html { redirect_to vendors_url,
                                  notice: "Vendor #{@vendor.login_name} was successfully created." }
        format.json { render json: @vendor,
                             status: :created, location: @vendor }
      else
        format.html { render action: "new" }
        format.json { render json: @vendor.errors,
                             status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @vendor = Vendor.find(params[:id])

    respond_to do |format|
      if @vendor.update_attributes(params[:vendor])
        format.html { redirect_to vendors_url, notice: "Vendor #{@vendor.login_name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @vendor = Vendor.find(params[:id])
    @vendor.destroy

    respond_to do |format|
      format.html { redirect_to vendors_url }
      format.json { head :no_content }
    end
  end

 def dashboard
   @tab="dashboard"
   @total_listings = current_user.listings.count

 end

  def mylistings
    @tab="mylistings"
    @mylistings = current_user.listings.all
  end
end
