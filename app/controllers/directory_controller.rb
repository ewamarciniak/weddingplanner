class DirectoryController < ApplicationController
  skip_before_filter :authorize

  def index
    @tab="directory"
    #@listings = Listing.search(params[:search_query])
    @q = Listing.search(params[:q])
    @listings  = @q.result(:distinct => true)
    @q.build_condition if @q.conditions.empty?
    @q.build_sort if @q.sorts.empty?
     @json = @listings.to_gmaps4rails do|listing, marker|
    marker.infowindow render_to_string(:partial => "/listings/infowindow", :locals => { :listing => listing})
    marker.title "#{listing.business_name}"
    marker.json({ :address => listing.address}, )

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
