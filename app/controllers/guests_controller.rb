class GuestsController < ApplicationController
  skip_before_filter :authorize
  # GET /guests
  # GET /guests.json
  def index
    @tab="guestlist"
    if current_user.admin
      @guests = Guest.all
    else
      @guests = current_user.guests
    end

    respond_to do |format|
      format.html # index.html.erb
      format.pdf do
        pdf = GuestListPdf.new(@guests, view_context)
        send_data pdf.render, filename: "Guest_List.pdf",
                  type: "application/pdf",
                  disposition: "inline"
        format.json { render json: @guests }
      end
    end
  end

  # GET /guests/1
  # GET /guests/1.json
  def show
    @guest = get_guest(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @guest }
    end
  end

  # GET /guests/new
  # GET /guests/new.json
  def new
    @guest = Guest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guest }
    end
  end

  # GET /guests/1/edit
  def edit
    @guest = get_guest(params[:id])
  end

  # POST /guests
  # POST /guests.json
  def create
    @guest = Guest.new(params[:guest])
    @guest.user = current_user

    respond_to do |format|
      if @guest.save
        format.html { redirect_to @guest, notice: 'Guest was successfully created.' }
        format.json { render json: @guest, status: :created, location: @guest }
      else
        format.html { render action: "new" }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /guests/1
  # PUT /guests/1.json
  def update
    @guest = get_guest(params[:id])

    respond_to do |format|
      if @guest.update_attributes(params[:guest])
        format.html { redirect_to @guest, notice: 'Guest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    @guest = get_guest(params[:id])
    @guest.destroy

    respond_to do |format|
      format.html { redirect_to guests_url }
      format.json { head :no_content }
    end
  end

  private
  def get_guest(guest_id)
    Guest.find(guest_id)
  end
end
