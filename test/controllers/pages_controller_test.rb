require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get email" do
    get :email
    assert_response :success
  end

  test "should get menu" do
    get :menu
    assert_response :success
  end

  test "should get thank_you" do
    get :thank_you
    assert_response :success
  end

end
