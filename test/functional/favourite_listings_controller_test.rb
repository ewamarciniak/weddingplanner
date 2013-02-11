require 'test_helper'

class FavouriteListingsControllerTest < ActionController::TestCase
  setup do
    @favourite_listing = favourite_listings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:favourite_listings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create favourite_listing" do
    assert_difference('FavouriteListing.count') do
      post :create, favourite_listing: { listing_id: @favourite_listing.listing_id, user_id: @favourite_listing.user_id }
    end

    assert_redirected_to favourite_listing_path(assigns(:favourite_listing))
  end

  test "should show favourite_listing" do
    get :show, id: @favourite_listing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @favourite_listing
    assert_response :success
  end

  test "should update favourite_listing" do
    put :update, id: @favourite_listing, favourite_listing: { listing_id: @favourite_listing.listing_id, user_id: @favourite_listing.user_id }
    assert_redirected_to favourite_listing_path(assigns(:favourite_listing))
  end

  test "should destroy favourite_listing" do
    assert_difference('FavouriteListing.count', -1) do
      delete :destroy, id: @favourite_listing
    end

    assert_redirected_to favourite_listings_path
  end
end
