class InspirationsController < ApplicationController
  # GET /inspirations
  # GET /inspirations.json
  def index
    @tab="moodboard"
    @inspirations = current_user.inspirations.order("position")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inspirations }
    end
  end

  # GET /inspirations/1
  # GET /inspirations/1.json
  def show
    @inspiration = get_inspiration(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inspiration }
    end
  end

  # GET /inspirations/new
  # GET /inspirations/new.json
  def new
    @inspiration = Inspiration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inspiration }
    end
  end

  # GET /inspirations/1/edit
  def edit
    @inspiration = get_inspiration(params[:id])
  end

  # POST /inspirations
  # POST /inspirations.json
  def create
    @inspiration = current_user.inspirations.new(params[:inspiration])

    respond_to do |format|
      if @inspiration.save
        format.html { redirect_to @inspiration, notice: 'Inspiration was successfully created.' }
        format.json { render json: @inspiration, status: :created, location: @inspiration }
      else
        format.html { render action: "new" }
        format.json { render json: @inspiration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inspirations/1
  # PUT /inspirations/1.json
  def update
    @inspiration = get_inspiration(params[:id])

    respond_to do |format|
      if @inspiration.update_attributes(params[:inspiration])
        format.html { redirect_to @inspiration, notice: 'Inspiration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inspiration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspirations/1
  # DELETE /inspirations/1.json
  def destroy
    @inspiration = get_inspiration(params[:id])
    @inspiration.destroy

    respond_to do |format|
      format.html { redirect_to inspirations_url }
      format.json { head :no_content }
    end
  end

  def sort
    params[:inspiration].each_with_index do |id, index|
      Inspiration.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  private
  def get_inspiration(inspiration_id)
    Inspiration.find(inspiration_id)
  end
end
