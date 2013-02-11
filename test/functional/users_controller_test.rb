require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { admin: @user.admin, billing_address_city: @user.billing_address_city, billing_address_county: @user.billing_address_county, billing_address_line1: @user.billing_address_line1, billing_address_line2: @user.billing_address_line2, billing_address_postcode: @user.billing_address_postcode, company_name: @user.company_name, email: @user.email, first_name: @user.first_name, last_name: @user.last_name, login_name: @user.login_name, password: @user.password, password_digest: @user.password_digest, shipping_address_city: @user.shipping_address_city, shipping_address_county: @user.shipping_address_county, shipping_address_line1: @user.shipping_address_line1, shipping_address_line2: @user.shipping_address_line2, shipping_address_postcode: @user.shipping_address_postcode, vendor: @user.vendor }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { admin: @user.admin, billing_address_city: @user.billing_address_city, billing_address_county: @user.billing_address_county, billing_address_line1: @user.billing_address_line1, billing_address_line2: @user.billing_address_line2, billing_address_postcode: @user.billing_address_postcode, company_name: @user.company_name, email: @user.email, first_name: @user.first_name, last_name: @user.last_name, login_name: @user.login_name, password: @user.password, password_digest: @user.password_digest, shipping_address_city: @user.shipping_address_city, shipping_address_county: @user.shipping_address_county, shipping_address_line1: @user.shipping_address_line1, shipping_address_line2: @user.shipping_address_line2, shipping_address_postcode: @user.shipping_address_postcode, vendor: @user.vendor }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
