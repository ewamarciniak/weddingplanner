class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  before_filter :is_admin?, :only => [:index]
  skip_filter :authorize, :only => [:new, :create]

  def index
    @tab="users"
    @users = User.paginate page: params[:page], order: 'created_at desc', per_page: 10

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @tab="account"
    if  current_user
      if current_user.admin
        @user = User.find(params[:id])
      else
        @user = User.find(current_user.id)
      end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end


  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        if @user == current_user
          if current_user.admin
            format.html { redirect_to users_url,
                                      notice: "User #{@user.login_name} was successfully created." }
          end
        else
          format.html { redirect_to login_url,
                                    notice: "User #{@user.login_name} was successfully created, please log in." }
        end
        format.json { render json: @user,
                             status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors,
                             status: :unprocessable_entity }
      end
    end
  end


  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to root_url, notice: "User #{@user.login_name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    begin
      @user.destroy
      flash[:notice] = "User #{@user.login_name} deleted"
    rescue Exception => e
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end


  def dashboard
    if current_user.wedding_date==nil
    @now=Time.now.strftime(" %A, %d %B, %Y")
    else
    @wedding_date=current_user.wedding_date.strftime(" %A, %d %B, %Y")
   end
    @tab="dashboard"
    @total_invited = current_user.guests.where(:invitation_sent => true).count
    @total_accepted=current_user.guests.where(:rsvp => 'accepted').count
    @total_declined=current_user.guests.where(:rsvp => 'declined').count
    @total_awaiting_reply=current_user.guests.where(:rsvp => 'nor received').count
    @total_todos=current_user.todos.where(:completed => false).count
    @total_done=current_user.todos.where(:completed => true).count
  end

  def vendor_dashboard
    @total_listings = current_user.listings.count
  end

  def purchase_history
    @tab="purchases"
    @orders = current_user.orders.all
  end
end
